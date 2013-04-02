AMAZON_SEARCH = lambda do |context|
  # get amazon specific keys from yml here
  require 'amazon/ecs'
  require 'json'

  Amazon::Ecs.options = {
      :associate_tag => Settings.amazon.associate_tag,
      :AWS_access_key_id => Settings.amazon.access_key,
      :AWS_secret_key => Settings.amazon.secret_key
  }

  # make api call to amazon
  res = Amazon::Ecs.item_lookup(context.search_text, :id_type => 'ISBN', :merchant_id => 'Amazon', :search_index => 'Books', :response_group => 'Large')

  #log the search
  SearchLog.create(:search_term => context.search_text, :user => context.current_user, :vendor => Settings.amazon.vendor_name)

  results = Array.new

  if res.items.count > 0
    res.items.each do |item|

      item_attributes = item.get_element('ItemAttributes')
      offers = item.get_element('Offers')

      if !offers.nil?

        if !item_attributes.nil?

          result = {vendor: Settings.amazon.vendor_name,
                    price: offers.get('Offer/OfferListing/Price/Amount').to_f / 100,
                    cart: true,
                    buy: true,
                    rent: false,
                    cart_link: "cart_link",
                    buy_link: item.get('DetailPageURL'),
                    condition: offers.get('Offer/OfferAttributes/Condition'),
                    rent_link: "",
                    shipping: 0,
                    total_cost: offers.get('Offer/OfferListing/Price/Amount').to_f / 100,
                    notes: "",
                    best_offer: false,
                    results_string: item.to_s.to_json

          }

          results << result

        end

      end
    end
  end

  results
end
