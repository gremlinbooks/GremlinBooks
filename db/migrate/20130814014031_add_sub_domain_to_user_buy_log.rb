class AddSubDomainToUserBuyLog < ActiveRecord::Migration
  def change
    add_column :user_buy_logs, :sub_domain, :string
  end
end
