class UserBuyLog < ApplicationRecord
  #attr_accessible :isbn, :link, :user, :affiliate_percent, :item_cost, :sub_domain

  def self.user_buy_counts_by_customer
    count(:group => ["sub_domain"]).collect { | grouping, ct | [grouping, ct] }
  end

end
