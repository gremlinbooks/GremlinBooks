class AddSubDomainToTenant < ActiveRecord::Migration[5.1.7]
  def change
    add_column :tenants, :sub_domain, :string
  end
end
