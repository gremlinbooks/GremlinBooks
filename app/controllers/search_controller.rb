class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'amazon.rb'
    require 'dalli'
    require 'tracker.rb'

    if !params[:search].nil?
      isbns = params[:search].split(',')
      results = Hash.new

      isbns.each do |isbn|
        tracker = Tracker.new()
        tracker.track_user_search(isbn, current_user)

        isbn_result = Rails.cache.read(isbn.strip)

        if isbn_result.nil?    # not in cache
          book_info = BookInfo.new(isbn.strip, current_user)
          vendor = VendorSearch.new()
          result = Array.new

          if book_info.title
            result << book_info
            result << vendor.get_all_results(isbn.strip, current_user)

            Rails.cache.write(isbn.strip, result, :expires_in => 1440.minutes)
            results[isbn.strip] = result
          end
        else #in cache - use it
          results[isbn.strip] = isbn_result
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

  def buy
    require 'tracker.rb'
    tracker = Tracker.new()
    tracker.track_buy_click(params)
    redirect_to params[:buy_link]
  end

end
