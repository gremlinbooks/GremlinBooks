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
    book_renter_results = GetBookRenterResults(search_text, current_user)
    amazon_results + chegg_results + book_byte_results + book_renter_results
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
                    price: "10.00",
                    cart: false,
                    buy: false,
                    rent: true,
                    cart_link: "cart_link",
                    buy_link: "Buy Link",
                    condition: "condition",
                    rent_link: "rent link",
                    shipping: "",
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
    if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["IsOfferAvailable"]
      results << {vendor: "Book Byte",
                  price: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  condition: "Used",
                  rent_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"].to_f,
                  results_string: book_byte_response
      }
    end

    #best new
    if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["IsOfferAvailable"]
      results << {vendor: "Book Byte",
                  price: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  condition: "New",
                  rent_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"].to_f,
                  results_string: book_byte_response
      }
    end

    #rentals?

    #marketplace new
    if book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["IsOfferAvailable"]
      results << {vendor: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["SellerName"],
                  price: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Cart_URL"],
                  condition: "New",
                  rent_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"].to_f,
                  results_string: book_byte_response
      }
    end

    #marketplace used
    if book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["IsOfferAvailable"]
      results << {vendor: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["SellerName"],
                  price: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Cart_URL"],
                  condition: "Used",
                  rent_link: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"].to_f,
                  results_string: book_byte_response
      }
    end

    results
  end

  def GetBookRenterResults(search_text, current_user)
    require 'typhoeus'

    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => "BookRenter")
    results = Array.new

    book_renter_request = Typhoeus::Request.new("http://www.bookrenter.com/api/fetch_book_info",
                                                :body => "this is a request body",
                                                :method => :post,
                                                :headers => {:Accept => "text/html"},
                                                :timeout => 100, # milliseconds
                                                :params => {:developer_key => "FqRlncrCJCxKKaRwQaphKGKiH4mNWwdf",
                                                            :version => "2011-02-01",
                                                            :book_details => "y",
                                                            :format => "js",
                                                            :isbn => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_renter_request
    hydra.run

    book_renter_response = ActiveSupport::JSON.decode(book_renter_request.response.body)

    results << {vendor: "Book Renter",
                price: book_renter_response["response"]["book"]["info"]["retail_price"].to_f,
                cart: true,
                buy: false,
                rent: true,
                cart_link: book_renter_response["response"]["book"]["add_to_cart_url"],
                buy_link: "",
                condition: "Used",
                rent_link: book_renter_response["response"]["book"]["add_to_cart_url"],
                shipping: "0",
                total_cost: book_renter_response["response"]["book"]["info"]["retail_price"].to_f + 0,
                results_string: book_renter_response
    }

    results
  end

end