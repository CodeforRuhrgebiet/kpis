class Mailinglist
  def self.stats
    members_non_digested_count = false
    members_digested_count = false

    a = Mechanize.new
    a.get(@@config['mailinglist']['mailman_listinfo_url']) do |page|
      mailinglist_page = page.form_with(action: "../roster/#{@@config['mailinglist']['slug']}") do |f|
        f.field_with(name: 'roster-email').value = @@config['mailinglist']['email']
        f.field_with(name: 'roster-pw').value = @@config['mailinglist']['password']
      end.click_button

      newsletter_members = { non_digested: false, digested: false, total: false }
      doc = mailinglist_page.parser
      res = doc.css("td[bgcolor='#FFF0D0']")

      members_non_digested_count = res[0].css("font[color='#000000']").text.to_i
      members_digested_count = res[1].css("font[color='#000000']").text.to_i
    end

    {
      members_non_digested_count: members_non_digested_count,
      members_digested_count: members_digested_count,
      members_total_count: members_non_digested_count + members_digested_count
    }
  end
end