class Comment < ActiveRecord::Base
  validates :content, :presence => true
  
  belongs_to :post

end

# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

