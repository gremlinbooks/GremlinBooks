class AddUrlToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :url, :string
  end
end
