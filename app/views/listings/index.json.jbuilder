json.array!(@listings) do |listing|
  json.extract! listing, :id, :is_active, :latest_price, :floor, :unit, :sqft, :bath, :bed, :left_window, :middle_window, :right_window, :floorplan_image, :last_updated
end
