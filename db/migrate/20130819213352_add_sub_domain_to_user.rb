class AddSubDomainToUser < ActiveRecord::Migration[5.1.7]
  def change
    add_column :users, :sub_domain, :string
  end
end
