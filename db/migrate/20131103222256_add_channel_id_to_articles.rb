class AddChannelIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :channel_id, :integer
  end
end
