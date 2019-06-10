class AddSubDomainToSearchLog < ActiveRecord::Migration[5.1.7]
  def change
    add_column :search_logs, :sub_domain, :string
  end
end
