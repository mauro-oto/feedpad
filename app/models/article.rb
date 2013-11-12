class Article < ActiveRecord::Base
  belongs_to :channel

  require 'feedzirra'

  def self.generate_articles(url, channel_id)
    feed = Feedzirra::Feed.fetch_and_parse(url)
    add_entries(feed.entries, channel_id)
    channel = Channel.find(channel_id)
    if !channel.name
      channel.name = feed.title
      channel.save
    end
  end

  def self.add_entries(entries, channel_id)
    entries.each do |entry|
      unless exists? :link => entry.url
        create!(
          :title => entry.title,
          :link => entry.url,
          :description => entry.summary,
          :pubDate => entry.published,
          :channel_id => channel_id,
          :unread => "yes",
          :star => "no"
        )
      end
    end
  end
  
  def self.update_feeds
    User.all.each do |u|
      u.channels.each do |c|
        Article.generate_articles(c.url, c.id)
      end
    end
  end

  def self.unread
    where(:unread => "yes")
  end

end
