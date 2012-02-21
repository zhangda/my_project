class Event < ActiveRecord::Base

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :start => self.starts_at.rfc822,
      #:description => self.description || "",
      :end => self.ends_at.rfc822,
      #:allDay => self.all_day,
      #:recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

end

# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#

