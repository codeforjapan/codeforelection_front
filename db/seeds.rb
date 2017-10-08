# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "started!"


prefs = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県)
prefs.each_with_index do |pref, index|
  Pref.create(pref_code: sprintf("%02d",index+1), name: pref)
  print "."
end



require 'open-uri'
require 'json'

url = 'https://raw.githubusercontent.com/codeforjapan/codeforelection/master/data/json/postal2senkyoku.light.json'
file = open(url)
json = JSON.parse(file.read)
json.each do |address|
  p Senkyoku.create!(zip_code: address[0], pref_code: address[1]["p"], senkyoku_no: address[1]["s"])
  print "."
end

puts "finished!"
