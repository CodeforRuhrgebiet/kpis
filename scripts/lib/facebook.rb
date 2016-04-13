class Facebook
  def self.stats
    page = Nokogiri::HTML(open(@@config['facebook']['sharebutton_url']))
    likes_count = page.css('.pluginCountTextConnected').text.to_i
    { likes_count: likes_count }
  end
end
