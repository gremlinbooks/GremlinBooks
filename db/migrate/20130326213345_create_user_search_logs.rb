class CreateUserSearchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_search_logs do |t|
      t.string :search_term
      t.string :user

      t.timestamps
    end
  end
end
