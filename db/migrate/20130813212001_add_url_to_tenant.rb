class AddUrlToTenant < ActiveRecord::Migration[5.1]
  def change
    add_column :tenants, :url, :string
  end
end
