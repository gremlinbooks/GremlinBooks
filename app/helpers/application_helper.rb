module ApplicationHelper

  def convert_to_currency(price)
    if price.to_s.include? "$"
      price
    else
      number_to_currency(price)
    end
  end

end
