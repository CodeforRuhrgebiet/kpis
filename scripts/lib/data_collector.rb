class DataCollector
  require 'firebase'

  include ERB::Util

  def initialize
  end

  def fetch!
    @mailinglist = Mailinglist.stats
    @meetup = Meetup.stats
    @twitter = TwitterAccount.stats
    @facebook = Facebook.stats
  end

  def track!
    base_uri = 'https://code-for-ruhrgebiet.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    push_to_firebase!(firebase, 'meetup', @meetup)
    push_to_firebase!(firebase, 'mailinglist', @mailinglist)
    push_to_firebase!(firebase, 'twitter', @twitter)
    push_to_firebase!(firebase, 'facebook', @facebook)
  end

  def save_to_file!
    File.open('./README.md', 'w') { |f| f.write(ERB.new(File.read('./templates/readme.md.erb')).result(binding)) }
  end

  private

  def current_day_entry(data)
    data.each { |entry| return entry if entry[1]['timestamp'] == current_date_timestamp }
    nil
  end

  def date_data
    {
      timestamp: Date.today.to_time.to_i,
      year: Date.today.year,
      month: Date.today.month,
      day: Date.today.day
    }
  end

  def current_date_timestamp
    Date.today.to_time.to_i
  end

  def push_to_firebase!(firebase, key, data)
    response = firebase.get("kpis/#{key}")
    if response.raw_body != 'null'
      result = JSON.parse(response.raw_body)
      current_day_entry_res = current_day_entry(result)
      if current_day_entry_res
        puts 'Updating day value..'
        node = current_day_entry_res.first
        firebase.update("kpis/#{key}/#{node}", date_data.merge(data))
      else
        puts 'Creating day value..'
        firebase.push("kpis/#{key}", date_data.merge(data))
      end
    else
      puts 'Needs to initialize!'
      firebase.push("kpis/#{key}", date_data.merge(data))
    end
  end
end
