json.array!(@rents) do |rent|
  json.extract! rent, :id, :listing_id, :fetch_date, :price
  json.url rent_url(rent, format: :json)
end
