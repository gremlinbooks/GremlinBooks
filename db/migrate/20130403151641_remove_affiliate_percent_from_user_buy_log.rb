class RemoveAffiliatePercentFromUserBuyLog < ActiveRecord::Migration[5.1.7]
  def change
    remove_column :user_buy_logs, :AffiliatePercent
  end
end
