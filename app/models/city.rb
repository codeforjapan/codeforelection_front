class City < ApplicationRecord
  validates :city_code, presence: true, uniqueness: true
  
end
