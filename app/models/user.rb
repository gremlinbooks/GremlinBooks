class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :sub_domain
  # attr_accessible :title, :body

  def self.user_counts_by_customer
    count(:group => ["sub_domain"]).collect { | grouping, ct | [grouping, ct] }
  end


end
