class AddSubDomainToTenant < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :sub_domain, :string
  end
end
