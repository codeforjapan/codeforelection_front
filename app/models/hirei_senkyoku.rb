class HireiSenkyoku < ApplicationRecord

  has_many :hirei_senkyoku_prefs
  has_many :prefs, through: :hirei_senkyoku_prefs

  validates :name, presence: true, uniqueness: true
end
