class VendorSearch
  attr_reader :search_text, :current_user
  attr_accessor :mapper

  def initialize()
    @mapper = AMAZON_SEARCH

  end

  def GetAllResults(search_text, current_user)
    amazon_results = GetAmazonResults(search_text, current_user)
    chegg_results = GetCheggResults(search_text, current_user)
    book_byte_results = GetBookByteResults(search_text, current_user)
    amazon_results + chegg_results + book_byte_results
  end

  def GetAmazonResults(search_text, current_user)
    @search_text = search_text
    @current_user = current_user
    @mapper.call(self)
  end

  def GetCheggResults(search_text, current_user)
    require 'typhoeus'

    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => "Chegg")
    results = Array.new

    chegg_request = Typhoeus::Request.new("http://api.chegg.com/rent.svc",
                                          :body => "this is a request body",
                                          :method => :post,
                                          :headers => {:Accept => "text/html"},
                                          :timeout => 100, # milliseconds
                                          :params => {:KEY => "1522fa5538fd041d8855c507ac1bf6a5",
                                                      :isbn => search_text,
                                                      :V => "2.0",
                                                      :PW => "4190344",
                                                      :R => "JSON"})

    hydra = Typhoeus::Hydra.new
    hydra.queue chegg_request
    hydra.run

    chegg_response = ActiveSupport::JSON.decode(chegg_request.response.body)

    chegg_result = {vendor: "Chegg",
                    author: "Author",
                    title: chegg_response["Data"]["Items"][0]["BookInfo"]["Title"],
                    price: "$10.00",
                    cart: false,
                    buy: false,
                    rent: true,
                    cart_link: "cart_link",
                    buy_link: "Buy Link",
                    condition: "condition",
                    image_link: "",
                    rent_link: "rent link",
                    results_string: chegg_response
    }

    results << chegg_result
    results
  end

  def GetBookByteResults(search_text, current_user)
    require 'typhoeus'

    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => "BookByte")
    results = Array.new

    book_byte_request = Typhoeus::Request.new("http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx",
                                              :body => "this is a request body",
                                              :method => :post,
                                              :headers => {:Accept => "text/html"},
                                              :timeout => 100, # milliseconds
                                              :params => {:AuthToken => "Lk1YwBqGUVIa4QOOcNT6oA==",
                                                          :PublisherId => "K620292",
                                                          :AffiliateType => "GAN",
                                                          :ItemIdType => "ISBN",
                                                          :ItemId => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_byte_request
    hydra.run

    book_byte_response = ActiveSupport::JSON.decode(book_byte_request.response.body)

    #best used
    results << {vendor: "Book Byte",
                        author: "Author",
                        title: "title",
                        price: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"],
                        cart: true,
                        buy: true,
                        rent: false,
                        cart_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                        buy_link: book_byte_response["InventoryInfo"]["Product_Detail_URL"],
                        condition: "Used",
                        image_link: "",
                        rent_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                        results_string: book_byte_response
    }

    #best new

    #rentals


    results
  end


end