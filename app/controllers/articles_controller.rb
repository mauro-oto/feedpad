class ArticlesController < ApplicationController

	def star_article
		@article = Article.find(params[:article_id])
		@channel = Channel.find(params[:channel_id])
		if @article.star == "no"
			@article.update_attributes(star: "yes")
		else
			@article.update_attributes(star: "no")
		end
		respond_to do |format|
          format.js
        end
	end

	def starred
		@starred = current_user.channels.to_a.collect {|c| c.articles.to_a }.flatten.select { |x| x.star == "yes" }.sort_by { |x| x.created_at }.reverse!
	end

end