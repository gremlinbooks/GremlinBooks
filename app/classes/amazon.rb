AMAZON_SEARCH = lambda do |context|
  require 'amazon/ecs'
  require 'json'
  require 'tracker.rb'

  tracker = Tracker.new()
  tracker.track_vendor_search(context.search_text, context.current_user, "Amazon")

  Amazon::Ecs.options = {
      :associate_tag => context.amazon_associate_tag,
      :AWS_access_key_id => context.amazon_access_key,
      :AWS_secret_key => context.amazon_secret_key
  }

  # make api call to amazon
  res = Amazon::Ecs.item_lookup(context.search_text, :id_type => 'ISBN', :search_index => 'Books', :response_group => 'Large')

  results = Array.new

  if res.items.count > 0
    res.items.each do |item|

      item_attributes = item.get_element('ItemAttributes')
      offers = item.get_element('Offers')

      if !offers.nil?

        if !item_attributes.nil?

          result = {vendor: "Amazon",
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
