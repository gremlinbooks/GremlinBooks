class SearchController < ApplicationController

  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'amazon.rb'

    if !params[:search].nil?
      #split search if more than one ISBN supplied
      isbns = params[:search].split(',')
      results = Hash.new

      isbns.each do |isbn|
        book_info = BookInfo.new()
        vendor = VendorSearch.new()
        result = Array.new

        result << book_info.GetBookInfo(isbn.strip, current_user)
        result << vendor.GetAllResults(isbn.strip, current_user)
        results[isbn.strip] = result
      end

      @search_results = results
    end

    respond_to do |format|
      format.html
      format.js do
        render :json => @search_results.to_json
      end
    end

  end



end
