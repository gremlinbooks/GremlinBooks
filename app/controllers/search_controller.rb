class SearchController < ApplicationController

  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'amazon.rb'
    require 'dalli'

    if !params[:search].nil?
      isbns = params[:search].split(',')
      results = Hash.new

      isbns.each do |isbn|
        #log the user search
        UserSearchLog.create!(:search_term => isbn, :user => current_user)

        #check cache for isbn first
        isbn_result = Rails.cache.read(isbn.strip)

        if !isbn_result.nil?
          results[isbn.strip] = isbn_result
        else #not in cache - get from vendors
          book_info = BookInfo.new()
          vendor = VendorSearch.new()
          result = Array.new

          book_info = book_info.GetBookInfoFromBookRenter(isbn.strip, current_user)

          if book_info
            result << book_info
            result << vendor.GetAllResults(isbn.strip, current_user)
            Rails.cache.write(isbn.strip, result)
            results[isbn.strip] = result
          end
        end
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
