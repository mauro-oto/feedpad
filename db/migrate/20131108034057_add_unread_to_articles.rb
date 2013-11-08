class AddUnreadToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :unread, :string
  end
end
