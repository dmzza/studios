class Listing < ActiveRecord::Base
  has_many :rents

  def latest_price
    rents.last.price
  end

  def windows
    count = 0
    if left_window
      count += 1
    end
    if middle_window
      count += 1
    end
    if right_window
      count += 1
    end
    count
  end

  def value_score
    latest_price.to_f / (sqft.to_f + windows * 7 + floor)
  end

  def floorplan_image
    "https://www.rentnema.com/img/floorplans/plan/#{floorplan}.jpg"
  end

  def price_changed_at
    rents.last.fetch_date
  end
end
