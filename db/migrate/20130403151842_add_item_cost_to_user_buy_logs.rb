class AddItemCostToUserBuyLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_buy_logs, :item_cost, :decimal
  end
end
