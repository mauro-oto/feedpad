class ArticlesController < ApplicationController

	def star_article
		@article = Article.find(params[:article_id])
		if @article.star == "no"
			@article.update_attributes(star: "yes")
		else
			@article.update_attributes(star: "no")
		end
		redirect_to channel_path(params[:channel_id])
	end

	def starred
		@starred = current_user.channels.to_a.collect {|c| c.articles.to_a }.flatten.select { |x| x.star == "yes" }.sort_by { |x| x.created_at }.reverse!
	end

end