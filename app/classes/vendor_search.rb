class VendorSearch
  attr_reader :search_text, :current_user
  attr_accessor :mapper

  def initialize()
    @mapper = AMAZON_SEARCH
  end

  def get_all_results(search_text, current_user)
    amazon_results = get_amazon_results(search_text, current_user)
    cj_results = get_cj_results(search_text, current_user)
    all_results = (amazon_results + cj_results).sort_by { |hsh| hsh[:total_cost] }
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

end