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
    result = ""

    if res.items.count > 0
      res.items.each do |item|

        item_attributes = item.get_element('ItemAttributes')

        if !item_attributes.nil?

          result = {author: item_attributes.get('Author'),
                    title: item_attributes.get('Title'),
                    image_link: item.get('MediumImage/URL'),
                    description: "",
                    retail_price: ""}

        end

      end
    end

    result
  end

  def GetBookInfoFromBookRenter(search_text, current_user)
    require 'typhoeus'

    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => Settings.book_renter.vendor_name)

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

    if book_renter_response["response"]["book"]
      result = {author: book_renter_response["response"]["book"]["info"]["authors"],
                title: book_renter_response["response"]["book"]["info"]["title"],
                image_link: book_renter_response["response"]["book"]["book_image_http"],
                description: book_renter_response["response"]["book"]["info"]["description"],
                retail_price: book_renter_response["response"]["book"]["info"]["retail_price"],
                publisher: book_renter_response["response"]["book"]["info"]["publisher"],
                binding: book_renter_response["response"]["book"]["info"]["book_binding"]}

      result
    end
  end

end



