class UserBuyLog < ActiveRecord::Base
  attr_accessible :isbn, :link, :user, :affiliate_percent, :item_cost, :sub_domain
end
