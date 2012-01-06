require 'open-uri'
class Feed < ActiveRecord::Base

  def self.update(url)
    feed = Feedzirra::Feed.fetch_and_parse(url)
    keywords = []
    add_entries(feed.entries, keywords)
  end

 
  private
    
    def self.add_entries(entries, keywords)
	entries.each do |entry|
	  if should_add?(entry, keywords)
            add_entry(entry)
          end
        end
    end	

    def self.has_keyword?(content, keywords)
       keywords.each do |keyword|
         if content.downcase.include? keyword.downcase
           return true
         end
       end
       return false
    end

    def self.add_entry(entry)
       create!(
              :title => entry.title,
              :url => entry.url,
              :summary => entry.summary,
              # :content => content,
              :published_at => entry.published,
              :guid => entry.id
       )
    end

    def self.should_add?(entry, keywords)
        if exists? :guid => entry.id
          return false
        end
        if keywords.empty? 
          return true
        end
        if has_keyword?(entry.summary, keywords)
          return true
        end
        begin
          doc = Nokogiri::HTML(open(entry.url).read)
          doc.xpath('//p').each do |node|
            if has_keyword?(node.text, keywords)
              return true
            end
          end
        rescue Exception => msg
          puts msg
        end
        return false
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

