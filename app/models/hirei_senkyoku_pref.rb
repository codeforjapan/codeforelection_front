class HireiSenkyokuPref < ApplicationRecord
  self.table_name = :hirei_senkyokus_prefs

  validates :pref_id, presence: true, uniqueness: { scope: :hirei_senkyoku_id }
  validates :hirei_senkyoku_id, presence: true

  belongs_to :pref
  belongs_to :hirei_senkyoku
end
