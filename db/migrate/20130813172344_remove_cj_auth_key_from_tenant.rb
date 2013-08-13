class RemoveCjAuthKeyFromTenant < ActiveRecord::Migration
  def change
    remove_column :tenants, :cj_auth_key
  end
end
