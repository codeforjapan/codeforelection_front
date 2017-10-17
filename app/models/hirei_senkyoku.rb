class HireiSenkyoku < ApplicationRecord

  has_many :hirei_senkyoku_prefs
  has_many :prefs, through: :hirei_senkyoku_prefs
  has_many :candidates, foreign_key: 'hirei_area_id', class_name: 'Candidate'

  validates :name, presence: true, uniqueness: true
end
