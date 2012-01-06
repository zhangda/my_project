class Feed < ActiveRecord::Base

  def self.update(url)
    feed = Feedzirra::Feed.fetch_and_parse(url)
    add_entries(feed.entries)
  end

 
  private
    
    def self.add_entries(entries)
	entries.each do |entry|	
	  unless exists? :guid => entry.id
            create!(
              :title => entry.title,
              :url => entry.url,
              :summary => entry.summary,
              :content => entry.content,
              :published_at => entry.published,
              :guid => entry.id
            )
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

