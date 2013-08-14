class AddSubDomainToSearchLog < ActiveRecord::Migration
  def change
    add_column :search_logs, :sub_domain, :string
  end
end
