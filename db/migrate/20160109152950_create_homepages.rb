class CreateHomepages < ActiveRecord::Migration
  def change
    create_table :homepages do |t|
      t.string :index

      t.timestamps null: false
    end
  end
end
