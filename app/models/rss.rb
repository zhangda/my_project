class Rss < ActiveRecord::Base
  attr_accessible :name

  validates :name,  :presence => true,
                     :length   => { :maximum => 200 },
                     :uniqueness => { :case_sensitive => false }


end

# == Schema Information
#
# Table name: rsses
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

