AMAZON_SEARCH = lambda do |context|
  # get amazon specific keys from yml here
  require 'amazon/ecs'
  require 'json'

  Amazon::Ecs.options = {
      :associate_tag => 'concllabs-20',
      :AWS_access_key_id => '0C0D1DMW0V4ZH49EZHR2',
      :AWS_secret_key => 'trNYD6Ky2UzMtjI0y0zMPq3ke24LQbrVCMYQ/DBf'
  }

  # make api call to amazon
  res = Amazon::Ecs.item_lookup(context.search_text, :id_type => 'ISBN', :merchant_id => 'Amazon', :search_index => 'Books', :response_group => 'Large')

  # map results to common interface (hash)
  results = Array.new

  if res.items.count > 0
    res.items.each do |item|

      item_attributes = item.get_element('ItemAttributes')
      offers = item.get_element('Offers')

      if !offers.nil?

        if !item_attributes.nil?

          result = {vendor: "Amazon",
                    author: item_attributes.get('Author'),
                    title: item_attributes.get('Title'),
                    price: offers.get('Offer/OfferListing/Price/FormattedPrice'),
                    cart: true,
                    buy: true,
                    cart_link: "cart_link",
                    buy_link: item.get('DetailPageURL'),
                    condition: "condition",
                    image_link: item.get('SmallImage/URL'),
                    results_string: item.to_s.to_json}

          results << result

        end



      end
    end
  end

  results
end
