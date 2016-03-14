require 'rubygems'
require 'mechanize'
require 'json'
require 'erb'

if !(ARGV[0] && ARGV[1])
  puts "invalid params!"
  exit
end

class MailinglistMembers
  include ERB::Util

  def initialize()
    @total_count = false
    @non_digested_count = false
    @digested_count = false
  end

  def fetch!
    a = Mechanize.new
    a.get('https://lists.okfn.org/mailman/listinfo/codeforruhrgebiet') do |page|
      mailinglist_page = page.form_with(action: '../roster/codeforruhrgebiet') do |f|
        f.field_with(name: 'roster-email').value = ARGV[0]
        f.field_with(name: 'roster-pw').value = ARGV[1]
      end.click_button

      newsletter_members = { non_digested: false, digested: false, total: false }
      doc = mailinglist_page.parser
      res = doc.css("td[bgcolor='#FFF0D0']")
      @non_digested_count = res[0].css("font[color='#000000']").text.to_i
      @digested_count = res[1].css("font[color='#000000']").text.to_i
      @total_count = @digested_count + @non_digested_count
    end
  end

  def save_to_file!
    File.open("./README.md","w") { |f| f.write(ERB.new(File.read('./templates/readme.md.erb')).result(binding)) }
  end
end

mm = MailinglistMembers.new
mm.fetch!
mm.save_to_file!
