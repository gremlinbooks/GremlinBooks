class RemoveCjAuthKeyFromTenant < ActiveRecord::Migration[5.1.7]
  def change
    remove_column :tenants, :cj_auth_key
  end
end
