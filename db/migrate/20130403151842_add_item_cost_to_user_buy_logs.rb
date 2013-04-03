class AddItemCostToUserBuyLogs < ActiveRecord::Migration
  def change
    add_column :user_buy_logs, :item_cost, :decimal
  end
end
