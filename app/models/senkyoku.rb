class Senkyoku < ApplicationRecord

  belongs_to :pref, foreign_key: "pref_code", primary_key: "pref_code"
  has_many :candidates
  has_many :senkyoku_zip_codes
  has_many :zipcodes, through: :senkyoku_zip_codes

  validates :pref_code, presence: true
  validates :senkyoku_no, presence: true

  def name
    "#{pref.name}第#{senkyoku_no}選挙区"
  end

end
