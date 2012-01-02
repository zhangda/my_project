class Post < ActiveRecord::Base
  validates :title,   :presence => true
  validates :content, :presence => true

  has_many :comments, :dependent => :destroy

end

# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

