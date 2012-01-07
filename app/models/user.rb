require 'digest'

class User < ActiveRecord::Base
   attr_accessor :password
   attr_accessible :name, :email, :password, :password_confirmation
   
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :name,  :presence => true,
                     :length   => { :maximum => 50 },
                     :uniqueness => { :case_sensitive => false }
   validates :email, :presence => true,
                     :format   => { :with => email_regex },
                     :uniqueness => { :case_sensitive => false }
   validates :password, :presence => true,
                        :confirmation => true,
                        :length => { :within => 4..10}

   before_save :encrypt_password

   
   def self.authenticate(name, submitted_password)
       user = find_by_name(name)
       # return nil if user.nil? 
       # return nil if user.encrypted_password != do_encrypt(submitted_password)
       return user
   end  
 
   private 
     def encrypt_password
       self.encrypted_password = do_encrypt(self.password)
     end
    
     def do_encrypt(string)
        Digest::SHA2.hexdigest(string)
     end

end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  admin              :boolean         default(FALSE)
#

