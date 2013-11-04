class ChannelsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @channel = current_user.channels.build
  end
  
  def index
    @channels = current_user.channels
  end
  
  def create
    @channel = Channel.new(channel_params)
    @channel.user_id = current_user.id
    @channel.save
    Article.generate_articles(@channel.url, @channel.id)
    redirect_to @channel
  end
  
  def show
    @channel = Channel.find(params[:id])
  end
    
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
 
    redirect_to channels_path
  end
  
  private
  def channel_params
    params.require(:channel).permit(:name, :url)
  end

  def set_channel
    @channel = current_user.channels.find(params[:id])
  end

end