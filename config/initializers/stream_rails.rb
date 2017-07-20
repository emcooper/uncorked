require 'stream_rails'

StreamRails.configure do |config|
  config.api_key     = ENV['STREAM_KEY']
  config.api_secret  = ENV['STREAM_SECRET']
  config.timeout     = 30                # Optional, defaults to 3
  config.location    = 'us-west'         # Optional, defaults to 'us-east'
  # If you use custom feed names, e.g.: timeline_flat, timeline_aggregated,
  # use this, otherwise omit:
  config.news_feeds = {
    flat: "venue_wines_flat"
  }
  # Point to the notifications feed group providing the name, omit if you don't
  # have a notifications feed
  # config.notification_feed = "notification"
end
