class CreateUserBuyLogs < ActiveRecord::Migration[5.1.7]
  def change
    create_table :user_buy_logs do |t|
      t.string :user
      t.string :isbn
      t.string :link

      t.timestamps
    end
  end
end
