class AddWindowsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :left_window, :bool
    add_column :listings, :middle_window, :bool
    add_column :listings, :right_window, :bool
  end
end
