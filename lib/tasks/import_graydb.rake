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
        wikidata_id_buf = line[0]
        name_last_buf = line[2]
        name_first_buf = line[3]
        name_last_furigana_buf = line[5].try(:split, " ").try(:[], 0)
        name_first_furigana_buf = line[5].try(:split, " ").try(:[], 1)
        party_id_buf = Party.where(short_name: line[6]).first

        # 選挙区テーブルからIDを取得
        senkyoku_id_buf = Senkyoku.where(pref_code: sprintf("%02d", line[11]), senkyoku_no: line[12]).first

        gender_buf = line[18] == "男性" ? 1 : 2
        birth_day_buf = line[19]
        birth_year_buf = line[21]
        twitter_id_buf = line[23]
        facebook_id_buf = line[24]
        official_website_url_buf = line[29]

        # テーブルデータ登録
        candidate = nil
        begin
          candidate = Candidate.find_or_initialize_by(wikidata_id: wikidata_id_buf)
          candidate.update_attributes!(
            wikidata_id: wikidata_id_buf,
            name_last: name_last_buf,
            name_first: name_first_buf,
            name_last_furigana: name_last_furigana_buf,
            name_first_furigana: name_first_furigana_buf,
            party_id: party_id_buf.try(:id),
            senkyoku_id: senkyoku_id_buf.try(:id),
            gender: gender_buf,
            birth_day: birth_day_buf,
            birth_year: birth_year_buf,
            twitter_id: twitter_id_buf,
            facebook_id: facebook_id_buf,
            official_website_url: official_website_url_buf
          )
        rescue Exception => e
          puts
          puts e
          p candidate.errors
          p sprintf("%02d", line[11])
          p line[12]
          p senkyoku_id_buf
          # exit
        end
      end
      i=i+1
    end

  end

end
