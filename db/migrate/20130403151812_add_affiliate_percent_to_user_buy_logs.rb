class AddAffiliatePercentToUserBuyLogs < ActiveRecord::Migration
  def change
    add_column :user_buy_logs, :affiliate_percent, :decimal
  end
end
