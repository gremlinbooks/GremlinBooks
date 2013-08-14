class AddSubDomainToUserSearchLog < ActiveRecord::Migration
  def change
    add_column :user_search_logs, :sub_domain, :string
  end
end
