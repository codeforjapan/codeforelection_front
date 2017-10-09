class Pref < ApplicationRecord
  has_many :senkyokus, foreign_key: "pref_code", primary_key: "pref_code"

  validates :pref_code, presence: true
  validates :name, presence: true

end
