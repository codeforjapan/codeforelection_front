class Candidate < ApplicationRecord

  belongs_to :senkyoku, optional: true
  belongs_to :party, optional: true
  belongs_to :hirei_senkyoku, optional: true, foreign_key: 'hirei_area_id', class_name: 'HireiSenkyoku'

  validates :name_first, presence: true
  validates :name_last, presence: true
  validates :wikidata_id, presence: true, uniqueness: true

  scope :single_name_search, ->(name) do
    where(
      '(name_last LIKE ? OR name_last_furigana LIKE ?)' +
      ' OR (name_first LIKE ? OR name_first_furigana LIKE ?)' +
      ' OR CONCAT(name_last, name_first) LIKE ?' +
      ' OR CONCAT(name_last_furigana, name_first_furigana) LIKE ?',
      *6.times.map { like_escape(name) + '%' }
    )
  end

  scope :pair_name_search, ->(last_name, first_name) do
    last_like = like_escape(last_name) + '%'
    first_like = like_escape(first_name) + '%'
    full_like = like_escape(last_name + first_name) + '%'
    where(
      '(name_last LIKE ? OR name_last_furigana LIKE ?)' +
      ' AND (name_first LIKE ? OR name_first_furigana LIKE ?)' +
      ' OR CONCAT(name_last, name_first) LIKE ?' +
      ' OR CONCAT(name_last_furigana, name_first_furigana) LIKE ?' +
      # User maybe input the part of candidate's first name.
      ' OR name_first LIKE ? OR name_first_furigana LIKE ?',
      last_like, last_like, first_like, first_like, *4.times.map { full_like }
    )
  end

  def self.like_escape(str)
    # http://d.hatena.ne.jp/teracc/20090703/1246576620
    str.gsub(/([\\%_])/, '\\\\\\1')
  end

  def age(unit = "")
    if self.birth_day.present?
      sprintf("%d",((Time.now.to_i - self.birth_day.to_time.to_i) / 60 / 60 / 24) / 365) + unit
    end
  end
  def full_name
  	"#{self.name_last} #{self.name_first}"
  end
  def full_name_furigana
  	"#{self.name_last_furigana} #{self.name_first_furigana}"
  end
  def birth_day_to_jp
    self.birth_day.try(:strftime, "%Y年%m月%d日") || '-'
  end
  def gender_label
    case self.gender
    when 1
      "男性"
    when 2
      "女性"
    else
      "-"
    end
  end
  def current_position_label
    case current_position
      when 1
        '現職'
      when 2
        '新人'
      when 3
        '元職'
      else
        '-'
    end
  end
  def is_hirei
    hirei_area_id.blank? ? false : true
  end
  def is_syosenkyoku
    senkyoku_id.blank? ? false : true
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
