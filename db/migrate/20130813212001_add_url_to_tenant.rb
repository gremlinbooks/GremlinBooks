class AddUrlToTenant < ActiveRecord::Migration[5.1.7]
  def change
    add_column :tenants, :url, :string
  end
end
