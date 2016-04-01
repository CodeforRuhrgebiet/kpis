class Facebook
  def self.stats
    page = Nokogiri::HTML(open(@@config['facebook']['sharebutton_url']))
    likes_count = page.css('.pluginCountTextConnected').text
    { likes_count: likes_count }
  end
end
