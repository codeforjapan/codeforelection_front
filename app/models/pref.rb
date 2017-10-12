class Pref < ApplicationRecord
  has_many :senkyokus, foreign_key: "pref_code", primary_key: "pref_code"

  has_one :hirei_senkyoku_pref
  has_one :hirei_senkyoku, through: :hirei_senkyoku_pref

  validates :pref_code, presence: true
  validates :name, presence: true

end
