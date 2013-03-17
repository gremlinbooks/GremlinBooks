class SearchController < ApplicationController

  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'amazon.rb'

    if !params[:search].nil?
      book_info = BookInfo.new()
      vendor = VendorSearch.new()

      @book_info = book_info.GetBookInfo(params[:search], current_user)
      @book_results = vendor.GetAllResults(params[:search], current_user)
    end

  end

end
