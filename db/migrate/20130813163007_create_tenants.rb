class CreateTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :tenants do |t|
      t.string :amazon_access_key
      t.string :amazon_secret_key
      t.string :amazon_associate_tag
      t.string :bookbyte_base_url
      t.string :bookbyte_auth_token
      t.string :bookbyte_publisher_id
      t.string :cj_website_id
      t.string :cj_auth_key
      t.string :cj_base_url
      t.string :bookrenter_base_url
      t.string :bookrenter_developer_key
      t.string :chegg_base_url
      t.string :chegg_password
      t.string :chegg_key
      t.string :chegg_aid
      t.string :chegg_pid
      t.string :chegg_sid
      t.string :logo
      t.string :color
      t.string :title

      t.timestamps
    end
  end
end
