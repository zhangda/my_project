class Keyword < ActiveRecord::Base
  attr_accessible :value
   
  belongs_to :user

  validates :value,  :presence => true,
                     :length   => { :maximum => 50 },
                     :uniqueness => { :case_sensitive => false }
  validates :user_id, :presence => true

 
end

# == Schema Information
#
# Table name: keywords
#
#  id         :integer         not null, primary key
#  value      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

