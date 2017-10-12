class Candidate < ApplicationRecord

  belongs_to :senkyoku, optional: true
  belongs_to :party, optional: true

  validates :name_first, presence: true
  validates :name_last, presence: true
  validates :wikidata_id, presence: true, uniqueness: true

  def age(unit = "")
    if self.birth_day.present?
      sprintf("%d",((Time.now.to_i - self.birth_day.to_time.to_i) / 60 / 60 / 24) / 365) + unit
    end
  end
  def full_name
  	"#{self.name_last} #{self.name_first}"
  end
  def full_name_furigana
  	"#{self.name_last} #{self.name_first}"
  end
  def birth_day_to_jp
    self.birth_day.try(:strftime, "%Y年%m月%d日") || '-'
  end
  def gender_label
    self.gender == 1 ? "男性" : "女性"
  end
  def current_position_label
    case current_position
      when 1
        '現職'
      when 2
        '新人'
      else
        '-'
    end
  end
  def is_hirei_label
    hirei_area_id.blank? ? '' : '比'
  end
  def twitter_link
    "https://twitter.com/#{self.twitter_id}" if self.twitter_id and self.twitter_id != '-'
  end
  def facebook_link
    self.facebook_id unless self.facebook_id == '-'
  end
  def official_website_link
    self.official_website_url
  end
end
