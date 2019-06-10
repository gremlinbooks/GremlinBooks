class AddSubDomainToSearchLog < ActiveRecord::Migration[5.1]
  def change
    add_column :search_logs, :sub_domain, :string
  end
end
