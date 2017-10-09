class Party < ApplicationRecord
  validates :full_name, presence: true, uniqueness: true
  validates :short_name, presence: true
end
