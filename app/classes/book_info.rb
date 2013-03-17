class BookInfo

  def initialize

  end

  def GetBookInfo(search_text, current_user)
    # get amazon specific keys from yml here
    require 'amazon/ecs'
    require 'json'

    Amazon::Ecs.options = {
        :associate_tag => 'concllabs-20',
        :AWS_access_key_id => '0C0D1DMW0V4ZH49EZHR2',
        :AWS_secret_key => 'trNYD6Ky2UzMtjI0y0zMPq3ke24LQbrVCMYQ/DBf'
    }

    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => "Amazon")

    # make api call to amazon
    res = Amazon::Ecs.item_lookup(search_text, :id_type => 'ISBN', :merchant_id => 'Amazon', :search_index => 'Books', :response_group => 'Large')

    # map results to common interface (hash)
    results = Array.new

    if res.items.count > 0
      res.items.each do |item|

        item_attributes = item.get_element('ItemAttributes')

        if !item_attributes.nil?

          result = {vendor: "Amazon",
                    author: item_attributes.get('Author'),
                    title: item_attributes.get('Title'),
                    # retail_price: offers.get('Offer/OfferListing/RetailPrice/FormattedPrice'),
                    image_link: item.get('MediumImage/URL'),
                    results_string: item.to_s.to_json}

          results << result

        end

      end
    end

    results
  end


end



