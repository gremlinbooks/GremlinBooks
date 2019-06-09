class UserSearchLog < ApplicationRecord
  #attr_accessible :search_term, :user, :sub_domain

  def self.user_search_counts_by_customer
    count(:group => ["sub_domain"]).collect { | grouping, ct | [grouping, ct] }
  end

end
