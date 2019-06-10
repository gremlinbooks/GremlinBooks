class AddSubDomainToUserBuyLog < ActiveRecord::Migration[5.1]
  def change
    add_column :user_buy_logs, :sub_domain, :string
  end
end
