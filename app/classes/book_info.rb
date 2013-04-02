class BookInfo

  attr_accessor :author, :title, :image_link, :description, :retail_price, :publisher, :binding

  def initialize(isbn, current_user)
    GetBookInfo(isbn, current_user)
  end

  private

  def GetBookInfo(isbn, current_user)
    require 'typhoeus'

    #log the search
    SearchLog.create(:search_term => isbn, :user => current_user, :vendor => Settings.book_renter.vendor_name)

    book_renter_request = Typhoeus::Request.new(Settings.book_renter.base_url,
                                                :body => "Gremlin Books",
                                                :method => :post,
                                                :headers => {:Accept => "text/html"},
                                                :timeout => 100, # milliseconds
                                                :params => {:developer_key => Settings.book_renter.developer_key,
                                                            :version => "2011-02-01",
                                                            :book_details => "y",
                                                            :format => "js",
                                                            :isbn => isbn})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_renter_request
    hydra.run

    book_renter_response = ActiveSupport::JSON.decode(book_renter_request.response.body)

    if book_renter_response["response"]["book"]
      #result = {author: book_renter_response["response"]["book"]["info"]["authors"],
      #          title: book_renter_response["response"]["book"]["info"]["title"],
      #          image_link: book_renter_response["response"]["book"]["book_image_http"],
      #          description: book_renter_response["response"]["book"]["info"]["description"],
      #          retail_price: book_renter_response["response"]["book"]["info"]["retail_price"],
      #          publisher: book_renter_response["response"]["book"]["info"]["publisher"],
      #          binding: book_renter_response["response"]["book"]["info"]["book_binding"]}
      #
      #result
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



