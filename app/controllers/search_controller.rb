class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    require 'vendor_search.rb'
    require 'dalli'
    require 'tracker.rb'

    if !params[:search].nil?
      isbns = params[:search].split(',')
      results = Hash.new

      isbns.each do |isbn|
        tracker = Tracker.new()
        tracker.track_user_search(isbn, current_user, request.subdomain)
        isbn = isbn.gsub("-", "")   # strip out the - if in submitted ISBN

        isbn_result = Rails.cache.read(isbn.strip + '-' + request.subdomain)
        tenant_info = get_tenant_params

        if isbn_result.nil?    # not in cache
          book_info = BookInfo.new(isbn.strip, current_user, tenant_info[:bookrenter_base_url], tenant_info[:bookrenter_developer_key], request.subdomain)
          vendor = VendorSearch.new(tenant_info)
          result = Array.new

          if book_info.title
            result << book_info
            result << vendor.get_all_results(isbn.strip, current_user)

            Rails.cache.write(isbn.strip + '-' + request.subdomain, result, :expires_in => 1440.minutes)
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
