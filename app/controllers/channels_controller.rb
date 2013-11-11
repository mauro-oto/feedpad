class ChannelsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @channel = current_user.channels.build
  end
  
  def index
    @channels = current_user.channels
    @latest_articles = current_user.channels.to_a.collect {|c| c.articles.to_a }.flatten.last(5)
  end
  
  def create
    @channel = Channel.new(channel_params)
    @channel.user_id = current_user.id

    respond_to do |format|
      if @channel.save
        format.html { redirect_to channels_path, notice: "Subscription to the channel was successful"}
        format.json { render json: @channel, status: :created, location: @channel }
      else
        format.html { render action: "new" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end

    Article.generate_articles(@channel.url, @channel.id)
  end

  def show
    @channel = Channel.find(params[:id])
    @articles = @channel.articles.order('pubDate DESC')
    @articles.each do |a|
      if a.unread
        a.update_attributes(:unread => "no")
      end
    end
  end
    
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
 
    redirect_to channels_path
  end
  
  private
  def channel_params
    params.require(:channel).permit(:url)
  end

  def set_channel
    @channel = current_user.channels.find(params[:id])
  end

end