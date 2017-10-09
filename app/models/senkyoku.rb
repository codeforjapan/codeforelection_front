class Senkyoku < ApplicationRecord

  belongs_to :pref, foreign_key: "pref_code", primary_key: "pref_code"
  has_many :candidates

  validates :zip_code, presence: true, uniqueness: true
  validates :pref_code, presence: true
  validates :senkyoku_no, presence: true

  def name
    "#{pref.name}第#{senkyoku_no}選挙区"
  end

end
