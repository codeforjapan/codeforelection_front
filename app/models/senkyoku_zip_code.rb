class SenkyokuZipCode < ApplicationRecord
  self.table_name = :senkyokus_zip_codes

  belongs_to :zip_code
  belongs_to :senkyoku

  validates :senkyoku_id, presence: true
  validates :zip_code_id, presence: true
  validates :zip_code_id, uniqueness: { scope: :senkyoku_id }

end
