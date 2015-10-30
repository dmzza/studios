class Listing < ActiveRecord::Base
  has_many :rents

  def latest_price
    rents.last.price
  end

  def value_score
    latest_price.to_f / sqft.to_f
  end
end
