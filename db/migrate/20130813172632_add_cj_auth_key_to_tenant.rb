class AddCjAuthKeyToTenant < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :cj_auth_key, :text
  end
end
