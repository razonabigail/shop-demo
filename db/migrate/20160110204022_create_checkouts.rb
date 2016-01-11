class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.string :encoded_url
      t.integer :affiliate_id
      t.integer :creatinve_id

      t.timestamps null: false
    end
  end
end
