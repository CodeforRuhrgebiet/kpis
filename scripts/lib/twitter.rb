class TwitterAccount
  def self.stats
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @@config['twitter']['consumer_key']
      config.consumer_secret     = @@config['twitter']['consumer_secret']
      config.access_token        = @@config['twitter']['access_token']
      config.access_token_secret = @@config['twitter']['access_token_secret']
    end

    followers_count = client.user(@@config['twitter']['screen_name']).followers_count
    { followers_count: followers_count }
  end
end
