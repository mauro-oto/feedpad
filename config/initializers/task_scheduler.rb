scheduler = Rufus::Scheduler.new

scheduler.every '5m' do
    Article.update_feeds
end
