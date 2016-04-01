class DataCollector
  include ERB::Util

  def initialize()
    @mailinglist = false
  end

  def fetch!
    @mailinglist = Mailinglist.stats
    @meetup = Meetup.stats
  end

  def save_to_file!
    File.open('./README.md', 'w') { |f| f.write(ERB.new(File.read('./templates/readme.md.erb')).result(binding)) }
  end
end
