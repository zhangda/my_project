require 'open-uri'
class Feed < ActiveRecord::Base

  def self.update(urls)
    urls.each do |url|
      feed = Feedzirra::Feed.fetch_and_parse(url)
      add_entries(feed.entries)
    end
  end

  def self.cleanup()
    destroy_all("published_at < '#{ Time.now - 1.day }'")
  end

 
  private
    
    def self.add_entries(entries)
	entries.each do |entry|
            add_entry(entry)
        end
    end	

    def self.add_entry(entry)
     if  !(exists? :guid => entry.id) and 
             (entry.published > Time.now - 1.day)
       create!(
              :title => entry.title,
              :url => entry.url,
              :summary => entry.summary,
              :content => get_content(entry),
              :published_at => entry.published,
              :guid => entry.id
       )
     end
   end

    def self.get_content(entry)
        text = ""
        begin
          doc = Nokogiri::HTML(open(entry.url).read)
          doc.xpath('//p').each do |node|
            text = text + node.text
          end
        rescue Exception => msg
          logger.error msg
        ensure 
          return text
        end
    end

end

# == Schema Information
#
# Table name: feeds
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  url          :string(255)
#  summary      :text
#  content      :text
#  published_at :datetime
#  guid         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

