class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :floor
      t.string :unit
      t.integer :sqft
      t.integer :bath
      t.integer :bed

      t.timestamps
    end
  end
end
