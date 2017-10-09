class Candidate < ApplicationRecord

  belongs_to :senkyoku
  belongs_to :party

  validates :name_first, presence: true
  validates :name_last, presence: true

end
