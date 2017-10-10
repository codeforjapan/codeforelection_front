class Candidate < ApplicationRecord

  belongs_to :senkyoku
  belongs_to :party

  validates :name_first, presence: true
  validates :name_last, presence: true
  validates :wikidata_id, presence: true, uniqueness: true

  def age(unit = "")
    if self.birth_day.present?
      sprintf("%d",((Time.now.to_i - self.birth_day.to_time.to_i) / 60 / 60 / 24) / 365) + unit
    else
      "未登録"
    end
  end
  def full_name
  	"#{self.name_last} #{self.name_first}"
  end
  def full_name_furigana
  	"#{self.name_last} #{self.name_first}"
  end
end
