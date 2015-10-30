json.array!(@units) do |unit|
   json.extract! unit, 'fi', 'uf', 'un', 'sq', 'bathType', 'bedType', 'rent'
end
