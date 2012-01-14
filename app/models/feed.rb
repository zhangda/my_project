# require 'open-uri'
class Feed < ActiveRecord::Base

  def self.update(urls)
    urls.each do |url|
      feed = Feedzirra::Feed.fetch_and_parse(url)
      add_entries(feed.entries)
    end
  end

  def self.cleanup()
    destroy_all("published_at < '#{ Time.zone.now - 1.day }'")
  end

 
  private
    
    def self.add_entries(entries)
        hydra = Typhoeus::Hydra.new
	entries.each do |entry|
          add_entry(entry, hydra)
        end
        hydra.run
    end	

    def self.add_entry(entry, hydra)
     if  !(exists? :guid => entry.id) and 
             (entry.published > Time.zone.now - 1.day)
         
        begin
          text = ""
          http_request = Typhoeus::Request.new(entry.url, :follow_location => true)
          http_request.on_complete do |response|
            doc = Nokogiri::HTML(response.body)
            doc.xpath('//p').each do |node|
              text = text + node.text
            end

             create!(
              :title => entry.title,
              :url => entry.url,
              :summary => entry.summary,
              :content => text.force_encoding("utf-8"),
              :published_at => entry.published,
              :guid => entry.id
            )
          end
          hydra.queue http_request
        rescue Exception => msg
          logger.error msg
        ensure
        end

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

