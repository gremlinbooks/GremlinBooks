class SearchController < ApplicationController

  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'amazon.rb'

    #log the search
    SearchLog.create(:search_term => params[:search], :user => current_user)

    # TODO: Need to conduct multiple searches here in parallel
    vendor = VendorSearch.new &AMAZON_SEARCH
    @res = vendor.getAPISearchResults(params[:search], current_user)
  end

end
