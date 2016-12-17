json.array!(@listings) do |listing|
  json.url listing_url(listing, format: :json)
  json.extract! listing, :id, :is_active, :latest_price, :floor, :unit, :sqft, :bath, :bed, :left_window, :middle_window, :right_window, :floorplan_image
end
