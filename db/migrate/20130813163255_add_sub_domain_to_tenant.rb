class AddSubDomainToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :sub_domain, :string
  end
end
