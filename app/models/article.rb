class Article < ActiveRecord::Base
  belongs_to :channel

  require 'feedzirra'

  def self.generate_articles(url, channel_id)
    feed = Feedzirra::Feed.fetch_and_parse(url)
    add_entries(feed.entries, channel_id)
  end

  def self.add_entries(entries, channel_id)
    entries.each do |entry|
      unless exists? :link => entry.url
        create!(
          :title => entry.title,
          :link => entry.url,
          :description => entry.summary,
          :pubDate => entry.published,
          :channel_id => channel_id
        )
      end
    end
  end

end
