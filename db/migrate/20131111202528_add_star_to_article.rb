class AddStarToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :star, :string
  end
end
