class SearchController < ApplicationController

  before_filter :authenticate_user!

  def index
    require 'amazon/ecs'

    Amazon::Ecs.options = {
        :associate_tag => 'concllabs-20',
        :AWS_access_key_id => '0C0D1DMW0V4ZH49EZHR2',
        :AWS_secret_key => 'trNYD6Ky2UzMtjI0y0zMPq3ke24LQbrVCMYQ/DBf'
    }

    @res = Amazon::Ecs.item_lookup(params[:search], :id_type => 'ISBN', :search_index => 'Books')


  end

end
