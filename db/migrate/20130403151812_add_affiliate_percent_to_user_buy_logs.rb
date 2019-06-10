class AddAffiliatePercentToUserBuyLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_buy_logs, :affiliate_percent, :decimal
  end
end
