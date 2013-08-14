class UserSearchLog < ActiveRecord::Base
  attr_accessible :search_term, :user, :sub_domain
end
