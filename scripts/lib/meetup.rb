class Meetup
  def self.stats
    url = "https://api.meetup.com/OK-Lab-Ruhrgebiet?&sign=true&photo-host=public&only=members&key=#{@@config['meetup']['api_key']}"
    api_result = JSON.load(open(url))

    { members_count: api_result['members'] }
  end
end
