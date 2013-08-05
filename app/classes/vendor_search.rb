class VendorSearch
  attr_reader :search_text, :current_user
  attr_accessor :mapper

  def initialize()
    @mapper = AMAZON_SEARCH
  end

  def get_all_results(search_text, current_user)
    amazon_results = get_amazon_results(search_text, current_user)
    cj_results = get_cj_results(search_text, current_user)
    chegg_results = get_chegg_results(search_text, current_user)
    book_byte_results = get_book_byte_results(search_text, current_user)
    book_renter_results = get_book_renter_results(search_text, current_user)
    all_results = (amazon_results + book_byte_results + book_renter_results + chegg_results + cj_results).sort_by { |hsh| hsh[:total_cost] }

    #all_results = (amazon_results + cj_results).sort_by { |hsh| hsh[:total_cost] }
    determine_best_offer(all_results)
  end

  private

  # mark best offer for item with lowest cost, but greater than 0
  def determine_best_offer(results)
    results.each do |result|
      result[:best_offer] = true if result[:total_cost] > 0
      break if result[:total_cost] > 0
    end

    results
  end

  def get_amazon_results(search_text, current_user)
    @search_text = search_text
    @current_user = current_user
    @mapper.call(self)
  end

  def get_cj_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'
    require 'nokogiri'
    require 'open-uri'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, 'CJ')

    results = Array.new

    cj_request = Typhoeus::Request.new(Settings.commission_junction.base_url,
                                       :method => :get,
                                       :headers => {:authorization => Settings.commission_junction.auth_key},
                                       :timeout => 100, # milliseconds
                                       :params => {:'website-id' => Settings.commission_junction.website_id,
                                                   :isbn => search_text,
                                                   :'advertiser-ids' => 'joined',
                                                   :'serviceable-area' => 'US'})

    hydra = Typhoeus::Hydra.new
    hydra.queue cj_request
    hydra.run

    xml = Nokogiri::XML(cj_request.response.body)
    xml.search('products').map do |product|

      results << {vendor: product.at('advertiser-name').text,
                  price: product.at('price').inner_text.to_f,
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: "",
                  buy_link: product.at('buy-url').text,
                  condition: "Buy",
                  rent_link: "",
                  shipping: 0,
                  total_cost: product.at('price').inner_text.to_f,
                  notes: "",
                  best_offer: false,
                  results_string: cj_request.response.body
      }
    end

    results

  end


  def get_chegg_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, Settings.chegg.vendor_name)

    results = Array.new

    chegg_request = Typhoeus::Request.new(Settings.chegg.base_url,
                                          :body => "Gremlin Books",
                                          :method => :post,
                                          :headers => {:Accept => "text/html"},
                                          :timeout => 100, # milliseconds
                                          :params => {:KEY => Settings.chegg.key,
                                                      :isbn => search_text,
                                                      :V => "2.0",
                                                      :PW => Settings.chegg.password,
                                                      :R => "JSON",
                                                      :with_pids => 1})

    hydra = Typhoeus::Hydra.new
    hydra.queue chegg_request
    hydra.run

    chegg_response = ActiveSupport::JSON.decode(chegg_request.response.body)

    if chegg_response["Data"]["Items"]
      chegg_response["Data"]["Items"].each do |item|
        if item["Renting"]
          if item["Terms"]
            item["Terms"].each do |term|
              results << {vendor: Settings.chegg.vendor_name,
                          price: term["price"].to_f,
                          cart: true,
                          buy: false,
                          rent: true,
                          cart_link: "",
                          buy_link: "",
                          condition: "Rent",
                          rent_link: "http://www.chegg.com/?referrer=CJGATEWAY&PID=#{Settings.chegg.pid}&AID=#{Settings.chegg.aid}&SID=#{Settings.chegg.sid}&pids=#{term["pid"]}",
                          shipping: 0,
                          total_cost: term["price"].to_f,
                          notes: term["name"],
                          best_offer: false,
                          results_string: chegg_response
              }
            end
          end
        end
      end
    end

    results
  end

  def get_book_byte_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, Settings.book_byte.vendor_name)

    results = Array.new

    book_byte_request = Typhoeus::Request.new(Settings.book_byte.base_url,
                                              :body => "Gremlin Books",
                                              :method => :post,
                                              :headers => {:Accept => "text/html"},
                                              :timeout => 100, # milliseconds
                                              :params => {:AuthToken => Settings.book_byte.auth_token,
                                                          :PublisherId => Settings.book_byte.publisher_id,
                                                          :AffiliateType => "GAN",
                                                          :ItemIdType => "ISBN",
                                                          :ItemId => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_byte_request
    hydra.run

    book_byte_response = ActiveSupport::JSON.decode(book_byte_request.response.body)

    #best used
    if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["IsOfferAvailable"]
      results << {vendor: Settings.book_byte.vendor_name,
                  price: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  condition: "Used",
                  rent_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"].to_f,
                  notes: "",
                  best_offer: false,
                  results_string: book_byte_response
      }
    end

    #best new
    if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["IsOfferAvailable"]
      results << {vendor: Settings.book_byte.vendor_name,
                  price: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Price"],
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  buy_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  condition: "New",
                  rent_link: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
                  shipping: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Shipping"],
                  total_cost: book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Price"].to_f,
                  notes: "",
                  best_offer: false,
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
                  total_cost: book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Price"].to_f,
                  notes: "",
                  best_offer: false,
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
                  notes: "",
                  best_offer: false,
                  results_string: book_byte_response
      }
    end

    results
  end

  def get_book_renter_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, Settings.book_renter.vendor_name)

    results = Array.new

    book_renter_request = Typhoeus::Request.new(Settings.book_renter.base_url,
                                                :body => "Gremlin Books",
                                                :method => :post,
                                                :headers => {:Accept => "text/html"},
                                                :timeout => 100, # milliseconds
                                                :params => {:developer_key => Settings.book_renter.developer_key,
                                                            :version => "2011-02-01",
                                                            :book_details => "y",
                                                            :format => "js",
                                                            :isbn => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_renter_request
    hydra.run

    book_renter_response = ActiveSupport::JSON.decode(book_renter_request.response.body)

    # book renter response is kind of jacked
    # first check if there is anything in the prices collection
    if  book_renter_response["response"]["book"]["prices"]
      # there are items in the prices collection
      # now pull out the rentals and purchases
      book_renter_response["response"]["book"]["prices"].each do |item|
        if item["term"] # rentals
          results << {vendor: "Book Renter",
                      price: item["rental_price"].sub('$', '').to_f,
                      cart: true,
                      buy: false,
                      rent: true,
                      cart_link: book_renter_response["response"]["book"]["add_to_cart_url"],
                      buy_link: "",
                      condition: "Rental",
                      rent_link: book_renter_response["response"]["book"]["add_to_cart_url"].sub('RENTAL_PERIOD', item["days"].to_s),
                      shipping: 0,
                      total_cost: item["rental_price"].sub('$', '').to_f,
                      notes: item["term"] + ' ' + item["days"],
                      best_offer: false,
                      results_string: book_renter_response
          }
        else
          if item["condition"] # purchase
            results << {vendor: "Book Renter",
                        price: item["purchase_price"].sub('$', '').to_f,
                        cart: true,
                        buy: true,
                        rent: false,
                        cart_link: book_renter_response["response"]["book"]["add_to_cart_url"].sub('RENTAL_PERIOD', 0.to_s),
                        buy_link: book_renter_response["response"]["book"]["add_to_cart_url"].sub('RENTAL_PERIOD', 0.to_s),
                        condition: item["condition"],
                        rent_link: "",
                        shipping: 0,
                        total_cost: item["purchase_price"].sub('$', '').to_f,
                        notes: "",
                        best_offer: false,
                        results_string: book_renter_response
            }
          end
        end
      end
    else
      # there aren't any price items in the collection, therefore pull standard book info
      results << {vendor: "Book Renter",
                  price: book_renter_response["response"]["book"]["info"]["retail_price"].sub('$', '').to_f,
                  cart: true,
                  buy: true,
                  rent: false,
                  cart_link: book_renter_response["response"]["book"]["add_to_cart_url"].sub('RENTAL_PERIOD', 0.to_s),
                  buy_link: book_renter_response["response"]["book"]["add_to_cart_url"].sub('RENTAL_PERIOD', 0.to_s),
                  condition: "Unknown",
                  rent_link: "",
                  shipping: 0,
                  total_cost: book_renter_response["response"]["book"]["info"]["retail_price"].sub('$', '').to_f,
                  notes: "",
                  best_offer: false,
                  results_string: book_renter_response
      }
    end

    results
  end


end