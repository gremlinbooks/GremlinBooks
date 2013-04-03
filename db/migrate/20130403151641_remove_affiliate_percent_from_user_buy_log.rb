class RemoveAffiliatePercentFromUserBuyLog < ActiveRecord::Migration
  def change
    remove_column :user_buy_logs, :AffiliatePercent
  end
end
