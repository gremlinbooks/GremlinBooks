class AddSubDomainToUserSearchLog < ActiveRecord::Migration[5.1.7]
  def change
    add_column :user_search_logs, :sub_domain, :string
  end
end
