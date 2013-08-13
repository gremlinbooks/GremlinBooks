class PagesController < ApplicationController

  def index

  end

  def mission

  end

  def customers
    @tenants = Tenant.all
  end

end
