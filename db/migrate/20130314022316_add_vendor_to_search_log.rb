class AddVendorToSearchLog < ActiveRecord::Migration[5.1]
  def change
    add_column :search_logs, :vendor, :string
  end
end
