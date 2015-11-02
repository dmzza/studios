class AddIsActiveToListings < ActiveRecord::Migration
  def change
    add_column :listings, :is_active, :bool
  end
end
