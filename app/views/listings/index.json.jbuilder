json.array!(@listings) do |listing|
  json.extract! listing, :id, :floor, :unit, :sqft, :bath, :bed
  json.url listing_url(listing, format: :json)
end
