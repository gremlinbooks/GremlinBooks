BOOKRENTER_SEARCH = lambda do | context |
  require 'net/http'

  # make api call to book renter
  url = URI.parse("http://webservices.bookbyte.com/rest/v1/getinventoryprice.aspx?AuthToken=wuXjdkixRqbX8jLPED8q%2BQ%3D%3D&PublisherId=K501829&AffiliateType=GAN&ItemIdType=ISBN&ItemId=#{params[:search]}")
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }

  @res2 = res.body

  # map results to common interface (hash array)
  results = Array.new

  result = { vendor: "Amazon",
             author: "author",
             title: "title",
             price: "price",
             cart: true,
             buy: true,
             cart_link: "cart_link",
             buy_link: "buy link",
             condition: "condition",
             image_link: "item url",
             results_string: @res }


  results << result
  results
end