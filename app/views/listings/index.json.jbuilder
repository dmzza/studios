json.array!(@listings) do |listing|
  json.extract! listing, :id, :is_active, :latest_price, :floor, :unit, :sqft, :bath, :bed, :left_window, :middle_window, :right_window
  json.url listing_url(listing, format: :json)
end
