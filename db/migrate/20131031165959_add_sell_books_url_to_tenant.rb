class AddSellBooksUrlToTenant < ActiveRecord::Migration[5.1.7]
  def change
    add_column :tenants, :sell_books_url, :string
  end
end
