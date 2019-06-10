class AddVendorToSearchLog < ActiveRecord::Migration[5.1.7]
  def change
    add_column :search_logs, :vendor, :string
  end
end
