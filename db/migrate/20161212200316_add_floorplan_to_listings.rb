class AddFloorplanToListings < ActiveRecord::Migration
  def change
    add_column :listings, :floorplan, :integer
  end
end
