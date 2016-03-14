require 'rubygems'
require 'mechanize'
require 'json'

if !(ARGV[0] && ARGV[1])
  puts "invalid params!"
  exit
end

a = Mechanize.new
a.get('https://lists.okfn.org/mailman/listinfo/codeforruhrgebiet') do |page|
  mailinglist_page = page.form_with(action: '../roster/codeforruhrgebiet') do |f|
    f.field_with(name: 'roster-email').value = ARGV[0]
    f.field_with(name: 'roster-pw').value = ARGV[1]
  end.click_button

  members = { non_digested: false, digested: false }
  doc = mailinglist_page.parser
  res = doc.css("td[bgcolor='#FFF0D0']")
  members[:non_digested] = res[0].css("font[color='#000000']").text.to_i
  members[:digested] = res[1].css("font[color='#000000']").text.to_i

  File.open("./mailinglist_members.json","w") { |f| f.write(members.to_json) }
end
