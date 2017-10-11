require 'open-uri'
require 'csv'

namespace :graydb do

  desc "GrayDBのデータをDBへインポートする" #=> 説明

  task :import => :environment do
    # CSVダウンロード:複数行項目対策
    csv_url = "https://raw.githubusercontent.com/hkwi/shuin48pre/master/docs/gdoc_gray_db.csv"
    filename = "#{Rails.root}/tmp/download.csv"

    open(csv_url) do |file|
      open(filename, "w+b") do |out|
       out.write(file.read)
     end
    end

    csv = CSV.read(filename)
    p header = csv.drop(3).first
    csv.drop(7).each do |line|

      wikidata_id_buf = line[header.index('UI用DBカラム名')] # wikidata_id
      next unless wikidata_id_buf.present?

      name_last_buf = line[header.index('name_last')]
      name_first_buf = line[header.index('name_first')]
      name_last_furigana_buf = line[header.index('name_full_furigana')].try(:split, " ").try(:[], 0)
      name_first_furigana_buf = line[header.index('name_full_furigana')].try(:split, " ").try(:[], 1)
      party_id_buf = Party.where(short_name: line[header.index('pary_id')]).first

      # 選挙区テーブルからIDを取得
      pref_code_buf = line[13].present? ? sprintf("%02d", line[13]) : nil
      senkyoku_id_buf = Senkyoku.where(pref_code: pref_code_buf, senkyoku_no: line[14]).first

      gender_buf = line[header.index('gender')] == "男性" ? 1 : 2
      birth_day_buf = line[header.index('birth_day')]
      birth_year_buf = line[header.index('birth_year')]
      twitter_id_buf = line[header.index('twitter_id')]
      facebook_id_buf = line[header.index('facebook_id')]
      official_website_url_buf = line[header.index('offiicial_website_url')]

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
        # exit
      end
    end # end of csv each line

  end # end of import task

end
