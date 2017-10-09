class Candidate < ApplicationRecord

  belongs_to :senkyoku
  belongs_to :party

  validates :name_first, presence: true
  validates :name_last, presence: true

  def age
  	"TBD"
  end
  def full_name
  	"#{self.name_last} #{self.name_first}"
  end
  def full_name_furigana
  	"#{self.name_last} #{self.name_first}"
  end
end
