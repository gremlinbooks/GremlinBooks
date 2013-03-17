class SearchLog < ActiveRecord::Base
  attr_accessible :search_term, :user, :vendor
end
