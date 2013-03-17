class AddVendorToSearchLog < ActiveRecord::Migration
  def change
    add_column :search_logs, :vendor, :string
  end
end
