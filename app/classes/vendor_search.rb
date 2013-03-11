class VendorSearch
  attr_reader :search_text, :current_user
  attr_accessor :mapper

  def initialize(&mapper)
    @mapper = mapper
    @book_info = BOOK_INFO
  end

  def getAPISearchResults(search_text, current_user)
    require 'typhoeus'

    @searchtext = search_text
    @current_user = current_user

    #get basic book info
    book_info = @book_info.call(self)

    #now get results from mapper sent in with initialize
    # TODO: reactor this so that all typhoeus calls use strategy pattern - how to make parallel calls and combine results into one resultset?
    results = @mapper.call(self)

    # CHEGG
    #===================================================================================================================
    hydra = Typhoeus::Hydra.new

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


    chegg_request.on_complete do |response|
      #post = JSON.parse(response.body)
       post = response.body

      return post
    end
    #===================================================================================================================

    # BOOK RENTER
    #===================================================================================================================
    second_request = Typhoeus::Request.new("http://www.pauldix.net",
                                           :body => "this is a request body",
                                           :method => :post,
                                           :headers => {:Accept => "text/html"},
                                           :timeout => 100, # milliseconds

                                           :params => {:field1 => "a field"})

    second_request.on_complete do |response|
      JSON.parse(response.body)



    end
    #===================================================================================================================

    hydra.queue chegg_request
    hydra.queue second_request
    hydra.run # this is a blocking call that returns once all requests are complete

    # Results
    chegg_results = chegg_request.handled_response # the value returned from the on_complete block
    # TODO: Combine chegg results with initial results

    second_request.handled_response # the value returned from the on_complete block (parsed JSON)

    results
  end

end