class Contact < ApplicationRecord
  #attr_accessible :comments, :email, :name

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
            :length => { :maximum => 50 }

  validates :email, :presence => true,
            :format => { :with => email_regex }

  validates :comments,  :presence => true,
            :length => { :maximum => 200 }


end
