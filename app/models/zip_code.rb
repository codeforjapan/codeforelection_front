class ZipCode < ApplicationRecord

  has_many :senkyoku_zip_codes
  has_many :senkyokus, through: :senkyoku_zip_codes

  validates :zip_code, presence: true, uniqueness: true
end
