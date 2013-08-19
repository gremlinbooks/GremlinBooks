class AddSubDomainToUser < ActiveRecord::Migration
  def change
    add_column :users, :sub_domain, :string
  end
end
