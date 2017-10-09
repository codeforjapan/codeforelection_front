require 'open-uri'
require 'csv'

namespace :import_graydb do

  desc "test" #=> 説明

  task :import => :environment do
    # CSVダウンロード:複数行項目対策
    csv_url = "https://raw.githubusercontent.com/hkwi/shuin48pre/master/docs/gdoc_gray_db.csv"
    filename = "download.csv"
    file = open(csv_url)
    open(csv_url) do |file|
       open(filename, "w+b") do |out|
           out.write(file.read)
       end
    end
    # CSV読み込み
    i = 0
    CSV.read(filename).each do |line|
      if(i > 6) # 先頭読み飛ばし
        # テーブルマッピング
        name_last_buf = line.name_last
        name_first_buf = line.name_first
        name_last_furigana_buf = line.name_full_furigana.split(" ")[0] 
        name_first_furigana_buf = line.name_full_furigana.split(" ")[1]
        party_id_buf = line.party_id
        
        # 選挙区テーブルからIDを取得
        senkyoku_id_buf = Senkyoku.where(pref_code: line.pref_code, senkyoku_no: line.senkyoku_no)

        gender_buf = line.gender == "男性" ? 1 : 2
        birth_day_buf = line.birth_day
        birth_year_buf = line.birth_year
        twitter_id_buf = line.twitter_id
        facebook_id_buf = line.facebook_id
        official_website_url_buf = line.official_website_url

        # テーブルデータ登録
        Candidate.create(
          name_last : name_last_buf,
          name_first : name_firrst_buf,
          name_last_furigana : name_last_furigana_buf, 
          name_first_furigana : name_first_furigana_buf,
          party_id : party_id_buf,
          senkyoku_id : senkyoku_id_buf,
          gender : gender_buf,
          birth_day : birth_day_buf,
          birth_year : birth_year_buf,
          twitter_id : twitter_id_buf,
          facebook_id : facebook_id_buf,
          official_website_url : official_website_url_buf
        )
      end
      i=i+1
    end

  end

end

