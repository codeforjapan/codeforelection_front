# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'


puts "started!"

# Prefecture
puts "\nPrefecture importing..."
prefs = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県)
prefs.each_with_index do |pref, index|
  Pref.find_or_create_by(pref_code: sprintf("%02d",index+1), name: pref)
  print "."
end

# City
puts "\nBigin to City import."
cities = []

city_url = 'https://raw.githubusercontent.com/codeforjapan/codeforelection/master/data/json/city2senkyoku.json'
file = open(city_url)
json = JSON.parse(file.read)
json.each do |city|
  cities << City.new(city_code: city[1]['cityCode'], city_name: city[1]['cityName'], pref_code: city[1]['prefCode'])
  print "."
end
puts "\nCity importing..."
City.import(cities)


# Senkyoku
puts "\nBeginto Senkyoku import."
pref_senkyoku_counts =
 [['01', 12], # 北海道
 ['02', 3], # 青森県
 ['03', 3], # 岩手県
 ['04', 6], # 宮城県
 ['05', 3], # 秋田県
 ['06', 3], # 山形県
 ['07', 5], # 福島県
 ['08', 7], # 茨城県
 ['09', 5], # 栃木県
 ['10', 5], # 群馬県
 ['11', 15], # 埼玉県
 ['12', 13], # 千葉県
 ['13', 25], # 東京都
 ['14', 18], # 神奈川県
 ['15', 6], # 新潟県
 ['16', 3], # 富山県
 ['17', 3], # 石川県
 ['18', 2], # 福井県
 ['19', 2], # 山梨県
 ['20', 5], # 長野県
 ['21', 5], # 岐阜県
 ['22', 8], # 静岡県
 ['23', 15], # 愛知県
 ['24', 4], # 三重県
 ['25', 4], # 滋賀県
 ['26', 6], # 京都府
 ['27', 19], # 大阪府
 ['28', 12], # 兵庫県
 ['29', 3], # 奈良県
 ['30', 3], # 和歌山県
 ['31', 2], # 鳥取県
 ['32', 2], # 島根県
 ['33', 5], # 岡山県
 ['34', 7], # 広島県
 ['35', 4], # 山口県
 ['36', 2], # 徳島県
 ['37', 3], # 香川県
 ['38', 4], # 愛媛県
 ['39', 2], # 高知県
 ['40', 11], # 福岡県
 ['41', 2], # 佐賀県
 ['42', 4], # 長崎県
 ['43', 4], # 熊本県
 ['44', 3], # 大分県
 ['45', 3], # 宮崎県
 ['46', 4], # 鹿児島県
 ['47', 4]] # 沖縄県

pref_senkyoku_counts.each do |pref|
  max_senkyoku_no = pref[1]
  pref_code = pref[0]

  (1..max_senkyoku_no).each do |senkyoku_no|
    Senkyoku.find_or_create_by(pref_code: pref_code, senkyoku_no: senkyoku_no)
    print "."
  end
end


# ZipCode
puts "\nBigin to Zipcode import."

postal_url = 'https://raw.githubusercontent.com/codeforjapan/codeforelection/master/data/json/postal2senkyoku.json'
file = open(postal_url)
json = JSON.parse(file.read)

zip_code_import = []
json.each do |address|
  zip_code_import << ZipCode.new(zip_code: address[0])
  print "."
end

begin
  puts "\nZipcode importing..."
  ZipCode.import(zip_code_import)
rescue Exception => e
  p e
end


# Senkyoku ~ Zipcode
puts "\nBegin to Senkyoku ~ Zipcode import."

zip_code_hash = {}
ZipCode.all.each {|z| zip_code_hash[z.zip_code] = z.id } # メモリー展開して高速化や！

city_hash = {}
City.all.each {|c| city_hash[c.city_code] = c.pref_code }

senkyoku_hash = {}
senkyoku_zip_code_import = []

json.each do |address|
  _pref_code = city_hash[address[1]['c']]
  _senkyoku_no = address[1]["s"]
  _hash_key = "#{_pref_code}-#{_senkyoku_no}"
  if senkyoku_hash.has_key?(_hash_key)
    senkyoku_id = senkyoku_hash[_hash_key]
  else
    senkyoku_id = Senkyoku.where(pref_code: _pref_code, senkyoku_no: _senkyoku_no).first.id
    senkyoku_hash[_hash_key] = senkyoku_id
  end

  senkyoku_zip_code_import << SenkyokuZipCode.new(zip_code_id: zip_code_hash[address[0]], senkyoku_id: senkyoku_id)
  print "."
end
begin
  puts "\nSenkyoku ~ Zipcode importing..."
  SenkyokuZipCode.import senkyoku_zip_code_import, validate: false
rescue Exception => e
  p e
end


# Party
Party.find_or_create_by(short_name: "こころ", full_name: "日本のこころ")
Party.find_or_create_by(short_name: "公明", full_name: "公明党")
Party.find_or_create_by(short_name: "共産", full_name: "日本共産党")
Party.find_or_create_by(short_name: "労働", full_name: "労働者党")
Party.find_or_create_by(short_name: "希望", full_name: "希望の党")
Party.find_or_create_by(short_name: "幸福", full_name: "幸福実現党")
Party.find_or_create_by(short_name: "新社", full_name: "新社会党")
Party.find_or_create_by(short_name: "民進", full_name: "民進党")
Party.find_or_create_by(short_name: "社民", full_name: "社会民主党")
Party.find_or_create_by(short_name: "立民", full_name: "立憲民主党")
Party.find_or_create_by(short_name: "維新", full_name: "日本維新の会")
Party.find_or_create_by(short_name: "自民", full_name: "自由民主党")
Party.find_or_create_by(short_name: "自由", full_name: "自由党")
Party.find_or_create_by(short_name: "無所属", full_name: "無所属")
Party.find_or_create_by(short_name: "諸派", full_name: "諸派")
Party.find_or_create_by(short_name: "支持政党なし", full_name: "支持政党なし")
Party.find_or_create_by(short_name: "新党大地", full_name: "新党大地")

# HireiSenkyokus
hireis = [['比例北海道ブロック', 8, ['01']],
['比例東北ブロック',	13, ['02', '03', '04', '05', '06', '07']],
['比例北関東ブロック',	19, ['08', '09', '10', '11']],
['比例南関東ブロック',	22, ['12', '14', '19']],
['比例東京ブロック',	17, ['13']],
['比例北陸信越ブロック',	11, ['15', '16', '17', '18', '20']],
['比例東海ブロック',	21, ['21', '22', '23', '24']],
['比例近畿ブロック',	28, ['25', '26', '27', '28', '29', '30']],
['比例中国ブロック',	11, ['31', '32', '33', '34', '35']],
['比例四国ブロック',	6, ['36', '37', '38', '39']],
['比例九州ブロック',	20, ['40', '41', '42', '43', '44', '45', '46', '47']]]
hireis.each do |hirei|

  hirei_senkyoku = HireiSenkyoku.find_or_create_by(name: hirei[0], capacity: hirei[1])

  prefs = hirei[2]
  prefs.each do |pref|
    pref = Pref.where(pref_code: pref).first

    begin
      HireiSenkyokuPref.find_or_create_by(pref_id: pref.id, 'hirei_senkyoku_id': hirei_senkyoku.id)
      print '.'
    rescue Exception => e
      p e
    end

  end # End of prefs loop.

end

puts "\nfinished!"
