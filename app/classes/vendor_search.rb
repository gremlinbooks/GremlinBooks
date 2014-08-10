class VendorSearch
  attr_reader :search_text, :current_user

  def initialize(params)
    @amazon_access_key = params[:amazon_access_key]
    @amazon_secret_key = params[:amazon_secret_key]
    @amazon_associate_tag = params[:amazon_associate_tag]
    @bookbyte_base_url = params[:bookbyte_base_url]
    @bookbyte_auth_token = params[:bookbyte_auth_token]
    @bookbyte_publisher_id = params[:bookbyte_publisher_id]
    @cj_website_id = params[:cj_website_id]
    @cj_auth_key = params[:cj_auth_key]
    @cj_base_url = params[:cj_base_url]
    @bookrenter_base_url = params[:bookrenter_base_url]
    @bookrenter_developer_key = params[:bookrenter_developer_key]
    @chegg_base_url = params[:chegg_base_url]
    @chegg_password = params[:chegg_password]
    @chegg_key = params[:chegg_key]
    @chegg_aid = params[:chegg_aid]
    @chegg_pid = params[:chegg_pid]
    @chegg_sid = params[:chegg_sid]
    @sub_domain = params[:sub_domain]
  end

  def get_all_isbn_results(search_text, current_user)
    amazon_results = get_amazon_results_from_isbn(search_text, current_user)
    cj_results = get_cj_results(search_text, current_user)
    chegg_results = get_chegg_results(search_text, current_user)
    book_byte_results = get_book_byte_results(search_text, current_user)
    book_renter_results = get_book_renter_results(search_text, current_user)
    all_results = (amazon_results + book_byte_results + book_renter_results + chegg_results + cj_results).sort_by { |hsh| hsh[:total_cost] }
    determine_best_offer(all_results)
  end

  def get_results_from_text(search_text, current_user)
    require 'amazon/ecs'
    require 'json'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, 'Amazon', @sub_domain)

    Amazon::Ecs.options = {
        :associate_tag => @amazon_associate_tag,
        :AWS_access_key_id => @amazon_access_key,
        :AWS_secret_key => @amazon_secret_key
    }

    # make api call to amazon
    res = Amazon::Ecs.item_search(search_text, :search_index => 'Books', :response_group => 'Large')

    results = Array.new

    if res.items.count > 0
      res.items.each do |item|

        item_attributes = item.get_element('ItemAttributes')
        offers = item.get_element('Offers')

        if !offers.nil?

          if !item_attributes.nil?

            result = {:title => item_attributes.get('Title'),
                :publisher => item_attributes.get('Publisher'),
                :author => item_attributes.get('Author'),
                :isbn => item_attributes.get('ISBN'),
                :small_image => item.get('SmallImage/URL'),
                :results_string => item.to_s
            }

            results << result

          end

        end
      end
    end

    results
  end

  private

  def determine_best_offer(results)
    # mark best offer for item with lowest cost, but greater than 0
    results.each do |result|
      result[:best_offer] = true if result[:total_cost] > 0
      break if result[:total_cost] > 0
    end

    results
  end

  def get_amazon_results_from_isbn(search_text, current_user)
    require 'amazon/ecs'
    require 'json'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, 'Amazon', @sub_domain)

    Amazon::Ecs.options = {
        :associate_tag => @amazon_associate_tag,
        :AWS_access_key_id => @amazon_access_key,
        :AWS_secret_key => @amazon_secret_key
    }

    # make api call to amazon
    res = Amazon::Ecs.item_lookup(search_text, :id_type => 'ISBN', :search_index => 'Books', :response_group => 'Large')

    results = Array.new

    if res.items.count > 0
      res.items.each do |item|

        item_attributes = item.get_element('ItemAttributes')
        offers = item.get_element('Offers')

        if !offers.nil?

          if !item_attributes.nil?

            result = {:vendor => "Amazon",
                :price => offers.get('Offer/OfferListing/Price/Amount').to_f / 100,
                :cart => true,
                :buy => true,
                :rent => false,
                :cart_link => "cart_link",
                :buy_link => item.get('DetailPageURL'),
                :condition => offers.get('Offer/OfferAttributes/Condition'),
                :rent_link => "",
                :shipping => 0,
                :total_cost => offers.get('Offer/OfferListing/Price/Amount').to_f / 100,
                :notes => "",
                :best_offer => false,
                :results_string => item.to_s.to_json
            }

            results << result

          end

        end
      end
    end

    results
  end

  def get_cj_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'
    require 'nokogiri'
    require 'open-uri'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, 'CJ', @sub_domain)

    results = Array.new

    cj_request = Typhoeus::Request.new(@cj_base_url,
                                       :method => :get,
                                       :headers => {:authorization => @cj_auth_key},
                                       :timeout => 100, # milliseconds
                                       :params => {:'website-id' => @cj_website_id,
                                                   :isbn => search_text,
                                                   :'advertiser-ids' => '1087150,1845757,520129,3812999,4020873,904879,2544507,4069992',
                                                   :'serviceable-area' => 'US'})

    hydra = Typhoeus::Hydra.new
    hydra.queue cj_request
    hydra.run

    xml = Nokogiri::XML(cj_request.response.body)
    xml.search('products').map do |product|

      if product.at('advertiser-name')

        results << {:vendor => product.at('advertiser-name').text,
            :price => product.at('price').inner_text.to_f,
            :cart => true,
            :buy => true,
            :rent => false,
            :cart_link => "",
            :buy_link => product.at('buy-url').text,
            :condition => "Buy",
            :rent_link => "",
            :shipping => 0,
            :total_cost => product.at('price').inner_text.to_f,
            :notes => "",
            :best_offer => false,
            :results_string => cj_request.response.body
        }

      end
    end

    results

  end

  def get_chegg_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, "Chegg", @sub_domain)

    results = Array.new

    chegg_request = Typhoeus::Request.new(@chegg_base_url,
                                          :body => "Gremlin Books",
                                          :method => :post,
                                          :headers => {:Accept => "text/html"},
                                          :timeout => 100, # milliseconds
                                          :params => {:KEY => @chegg_key,
                                                      :isbn => search_text,
                                                      :V => "2.0",
                                                      :PW => @chegg_password,
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
              results << {:vendor => "Chegg",
                  :price => term["price"].to_f,
                  :cart => true,
                  :buy => false,
                  :rent => true,
                  :cart_link => "",
                  :buy_link => "",
                  :condition => "Rent",
                  :rent_link => "http://chggtrx.com/click.track?CID=267582&AFID=305580&ADID=1088043&SID=#{@chegg_sid}&PIDs=#{term["pid"]}",
                  :shipping => 0,
                  :total_cost => term["price"].to_f,
                  :notes => term["name"],
                  :best_offer => false,
                  :results_string => chegg_response
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
    tracker.track_vendor_search(search_text, current_user, "Book Byte", @sub_domain)

    results = Array.new

    book_byte_request = Typhoeus::Request.new(@bookbyte_base_url,
                                              :body => "Gremlin Books",
                                              :method => :post,
                                              :headers => {:Accept => "text/html"},
                                              :timeout => 100, # milliseconds
                                              :params => {:AuthToken => @bookbyte_auth_token,
                                                          :PublisherId => @bookbyte_publisher_id,
                                                          :AffiliateType => "GAN",
                                                          :ItemIdType => "ISBN",
                                                          :ItemId => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_byte_request
    hydra.run

    book_byte_response = ActiveSupport::JSON.decode(book_byte_request.response.body)

    # create the url for a user buy click
    cart_url = book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Cart_URL"]

    if cart_url

      cart_url_parts = cart_url.split('&')
      ad_url = ''

      cart_url_parts.each do |part|
        if part.starts_with?('adurl=')
          ad_url = part.slice(6, part.length - 1)
        end
      end

      buy_url = "http://www.jdoqocy.com/click-#{@cj_website_id}-10365124?url=" + ad_url

      #best used
      if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["IsOfferAvailable"]
        results << {:vendor => "Book Byte",
            :price =>book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"],
            :cart => true,
            :buy => true,
            :rent => false,
            :cart_link => buy_url,
            :buy_link => buy_url,
            :condition => "Used",
            :rent_link => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Cart_URL"],
            :shipping => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Shipping"],
            :total_cost => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_Used"]["Price"].to_f,
            :notes => "",
            :best_offer => false,
            :results_string => book_byte_response
        }
      end

      #best new
      if book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["IsOfferAvailable"]
        results << {:vendor => "Book Byte",
            :price => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Price"],
            :cart => true,
            :buy => true,
            :rent => false,
            :cart_link => buy_url,
            :buy_link => buy_url,
            :condition => "New",
            :rent_link => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Cart_URL"],
            :shipping => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Shipping"],
            :total_cost => book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Bookbyte_Offers"]["Best_New"]["Price"].to_f,
            :notes => "",
            :best_offer => false,
            :results_string => book_byte_response
        }
      end

      #rentals?

      #marketplace new
      if book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["IsOfferAvailable"]
        results << {:vendor => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["SellerName"],
            :price => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Price"],
            :cart => true,
            :buy => true,
            :rent => false,
            :cart_link => buy_url,
            :buy_link => buy_url,
            :condition => "New",
            :rent_link => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Cart_URL"],
            :shipping => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Shipping"],
            :total_cost => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_New"]["Price"].to_f,
            :notes => "",
            :best_offer => false,
            :results_string => book_byte_response
        }
      end

      #marketplace used
      if book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["IsOfferAvailable"]
        results << {:vendor => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["SellerName"],
            :price => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"],
            :cart => true,
            :buy => true,
            :rent => false,
            :cart_link => buy_url,
            :buy_link => buy_url,
            :condition => "Used",
            :rent_link => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Cart_URL"],
            :shipping => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"],
            :total_cost => book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Shipping"].to_f + book_byte_response["InventoryInfo"]["Marketplace_Offers"]["Best_Used"]["Price"].to_f,
            :notes => "",
            :best_offer => false,
            :results_string => book_byte_response
        }
      end

    end

    results
  end

  def get_book_renter_results(search_text, current_user)
    require 'typhoeus'
    require 'tracker.rb'

    tracker = Tracker.new()
    tracker.track_vendor_search(search_text, current_user, 'Book Renter', @sub_domain)

    results = Array.new

    book_renter_request = Typhoeus::Request.new(@bookrenter_base_url,
                                                :body => "Gremlin Books",
                                                :method => :post,
                                                :headers => {:Accept => "text/html"},
                                                :timeout => 100, # milliseconds
                                                :params => {:developer_key => @bookrenter_developer_key,
                                                            :version => "2011-02-01",
                                                            :book_details => "y",
                                                            :format => "js",
                                                            :isbn => search_text})

    hydra = Typhoeus::Hydra.new
    hydra.queue book_renter_request
    hydra.run

    book_renter_response = ActiveSupport::JSON.decode(book_renter_request.response.body)

    if book_renter_response

      # create the url for a user buy click
      cart_url = book_renter_response["response"]["book"]["add_to_cart_url"]
      buy_url = "http://www.jdoqocy.com/click-#{@cj_website_id}-10737829?url="

      # book renter response is kind of jacked
      # first check if there is anything in the prices collection
      if  book_renter_response["response"]["book"]["prices"]
        # there are items in the prices collection
        # now pull out the rentals and purchases
        book_renter_response["response"]["book"]["prices"].each do |item|
          if item["term"] # rentals
            results << {:vendor => "Book Renter",
                        :price => item["rental_price"].sub('$', '').to_f,
                        :cart => true,
                        :buy => false,
                        :rent => true,
                        :cart_link => URI.encode(cart_url),
                        :buy_link => "",
                        :condition => "Rental",
                        :rent_link => buy_url + URI.encode(cart_url.sub('RENTAL_PERIOD', item["days"].to_s)),
                        :shipping => 0,
                        :total_cost => item["rental_price"].sub('$', '').to_f,
                        :notes => item["term"] + ' ' + item["days"],
                        :best_offer => false,
                        :results_string => book_renter_response
            }
          else
            if item["condition"] # purchase
              results << {:vendor => "Book Renter",
                          :price => item["purchase_price"].sub('$', '').to_f,
                          :cart => true,
                          :buy => true,
                          :rent => false,
                          :cart_link => buy_url + URI.encode(cart_url.sub('RENTAL_PERIOD', 90.to_s)),
                          :buy_link => buy_url + URI.encode(cart_url.sub('RENTAL_PERIOD', 90.to_s)),
                          :condition => item["condition"],
                          :rent_link => "",
                          :shipping => 0,
                          :total_cost => item["purchase_price"].sub('$', '').to_f,
                          :notes => "",
                          :best_offer => false,
                          :results_string => book_renter_response
              }
            end
          end
        end
      else
        # there aren't any price items in the collection, therefore pull standard book info
        results << {:vendor  => "Book Renter",
                    :price => book_renter_response["response"]["book"]["info"]["retail_price"].sub('$', '').to_f,
                    :cart => true,
                    :buy => true,
                    :rent => false,
                    :cart_link => buy_url + URI.encode(cart_url.sub('RENTAL_PERIOD', 90.to_s)),
                    :buy_link => buy_url + URI.encode(cart_url.sub('RENTAL_PERIOD', 90.to_s)),
                    :condition => "Unknown",
                    :rent_link => "",
                    :shipping => 0,
                    :total_cost => book_renter_response["response"]["book"]["info"]["retail_price"].sub('$', '').to_f,
                    :notes => "",
                    :best_offer => false,
                    :results_string => book_renter_response
        }
      end
    end

    results
  end



end