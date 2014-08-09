class SearchController < ApplicationController

  def index
    require 'vendor_search.rb'
    require 'dalli'
    require 'tracker.rb'
    require 'book_info.rb'

    if !params[:search].nil?

      results = Hash.new

      if isbn_search?(params[:search])
        #isbn search
        isbns = params[:search].split(',')

        isbns.each do |isbn|
          tracker = Tracker.new()
          tracker.track_user_search(isbn, current_user, request.subdomain)
          isbn = clean_isbn(isbn)

          isbn_result = Rails.cache.read(isbn.strip + '-' + request.subdomain)
          tenant_info = get_tenant_params

          if isbn_result.nil? # not in cache
            book_info = BookInfo.new(isbn.strip, current_user, tenant_info[:bookrenter_base_url], tenant_info[:bookrenter_developer_key], request.subdomain)
            vendor = VendorSearch.new(tenant_info)
            result = Array.new

            if book_info.title
              result << book_info
              result << vendor.get_all_isbn_results(isbn.strip, current_user)

              Rails.cache.write(isbn.strip + '-' + request.subdomain, result, :expires_in => 1440.minutes)
              results[isbn.strip] = result
            end
          else #in cache - use it
            results[isbn.strip] = isbn_result
          end
        end

        @search_results = results
        @isbn_search = true
      else
        # title/author search
        tenant_info = get_tenant_params
        vendor = VendorSearch.new(tenant_info)
        results[params[:search]] = vendor.get_results_from_text(params[:search], current_user)
        @search_results = results
        @isbn_search = false
      end

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

  private

  def isbn_search?(search_text)
    # search_text could be a text keyword or a comma delimited list of isbn's or a single isbn
    # if any one item in comma delimited list of isbn's is not a valid isbn, will treat like text keyword
    if search_text.split(',').count > 1
      search_text.split(',').each do |isbn|
        if !is_an_isbn?(clean_isbn(isbn))
          false
        end
      end
      true
    else
      if is_an_isbn?(search_text)
        true
      else
        false
      end
    end
  end

  def clean_isbn(unclean_isbn)
    unclean_isbn.gsub("-", "")
  end

  def is_an_isbn?(possible_isbn)
    possible_isbn.to_s.match(/(97(8|9))?\d{9}(\d|X)$/) == nil ? false : true
  end

end
