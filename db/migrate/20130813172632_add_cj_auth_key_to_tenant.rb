class AddCjAuthKeyToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :cj_auth_key, :text
  end
end
