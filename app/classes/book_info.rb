class BookInfo

  attr_accessor :author, :title, :image_link, :description, :retail_price, :publisher, :binding

  def initialize(isbn, current_user, bookrenter_base_url, bookrenter_developer_key)
    GetBookInfo(isbn, current_user, bookrenter_base_url, bookrenter_developer_key)
  end

  private

  def GetBookInfo(isbn, current_user, bookrenter_base_url, bookrenter_developer_key)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(:search_term => isbn, :user => current_user, :vendor => "Bookrenter")

    book_renter_request = Typhoeus::Request.new(bookrenter_base_url,
                                                :body => "Gremlin Books",
                                                :method => :post,
                                                :headers => {:Accept => "text/html"},
                                                :timeout => 100, # milliseconds
                                                :params => {:developer_key => bookrenter_developer_key,
                                                            :version => "2011-02-01",
                                                            :book_details => "y",
                                                            :format => "js",
                                                            :isbn => isbn})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_renter_request
    hydra.run

    book_renter_response = ActiveSupport::JSON.decode(book_renter_request.response.body)

    if book_renter_response["response"]["book"]
      @author =  book_renter_response["response"]["book"]["info"]["authors"]
      @title =  book_renter_response["response"]["book"]["info"]["title"]
      @image_link =  book_renter_response["response"]["book"]["book_image_http"]
      @description =  book_renter_response["response"]["book"]["info"]["description"]
      @retail_price =  book_renter_response["response"]["book"]["info"]["retail_price"]
      @publisher =  book_renter_response["response"]["book"]["info"]["publisher"]
      @binding =  book_renter_response["response"]["book"]["info"]["book_binding"]
    end
  end

end



