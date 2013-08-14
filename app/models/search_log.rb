class SearchLog < ActiveRecord::Base
  attr_accessible :search_term, :user, :vendor, :sub_domain
end
