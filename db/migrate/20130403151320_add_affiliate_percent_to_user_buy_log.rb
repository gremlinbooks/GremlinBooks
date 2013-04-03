class AddAffiliatePercentToUserBuyLog < ActiveRecord::Migration
  def change
    add_column :user_buy_logs, :AffiliatePercent, :decimal
  end
end
