class Candidate < ApplicationRecord

  belongs_to :senkyoku
  belongs_to :party

  validates :name_first, presence: true
  validates :name_last, presence: true
  validates :wikidata_id, presence: true, uniqueness: true

end
