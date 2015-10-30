class Rent < ActiveRecord::Base
  # attr_accessible :listing
  belongs_to :listing
end
