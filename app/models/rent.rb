class Rent < ActiveRecord::Base
  belongs_to :listing
  default_scope { order('fetch_date ASC') }
end
