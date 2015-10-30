class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.integer :listing_id
      t.datetime :fetch_date
      t.integer :price

      t.timestamps
    end
  end
end
