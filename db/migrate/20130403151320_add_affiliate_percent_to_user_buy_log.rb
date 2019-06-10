class AddAffiliatePercentToUserBuyLog < ActiveRecord::Migration[5.1.7]
  def change
    add_column :user_buy_logs, :AffiliatePercent, :decimal
  end
end
