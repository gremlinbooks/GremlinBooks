class AddSellBooksUrlToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :sell_books_url, :string
  end
end
