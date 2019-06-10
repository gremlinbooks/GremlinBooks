class CreateSearchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :search_logs do |t|
      t.string :search_term
      t.string :user

      t.timestamps
    end
  end
end
