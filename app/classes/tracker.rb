class Tracker

  def track_buy_click(params)
    #log the buy/rent link click
    UserBuyLog.create!(:user => params[:user],
                       :isbn => params[:isbn],
                       :link => params[:buy_link],
                       :affiliate_percent => '',
                       :item_cost => params[:item_cost],
                       :sub_domain => params[:sub_domain])
  end
  #handle_asynchronously :track_buy_click, :priority => 20

  def track_user_search(isbn, current_user, sub_domain)
    #log the user search
    UserSearchLog.create!(:search_term => isbn, :user => current_user, :sub_domain => sub_domain)
  end
  #handle_asynchronously :track_user_search, :priority => 20

  def track_vendor_search(search_text, current_user, vendor_name, sub_domain)
    #log the search
    SearchLog.create(:search_term => search_text, :user => current_user, :vendor => vendor_name, :sub_domain => sub_domain)
  end
  #handle_asynchronously :track_vendor_search, :priority => 20


end