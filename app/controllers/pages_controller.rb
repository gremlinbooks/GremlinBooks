class PagesController < ApplicationController

  def index

  end

  def mission

  end

  def customers
    @tenants = Tenant.all
    @search_counts = UserSearchLog.user_search_counts_by_customer
    @buy_counts = UserBuyLog.user_buy_counts_by_customer
  end

end
