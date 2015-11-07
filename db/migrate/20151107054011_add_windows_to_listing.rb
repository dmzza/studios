class AddWindowsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :left_window, :boolean
    add_column :listings, :middle_window, :boolean
    add_column :listings, :right_window, :boolean
  end
end
