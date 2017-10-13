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
    csv.drop(6).each do |line|

      wikidata_id_buf = line[header.index('UI用DBカラム名')] # wikidata_id
      next unless wikidata_id_buf.present?

      name_last_furigana_buf = line[header.index('name_full_furigana')].try(:split, " ").try(:[], 0)
      name_first_furigana_buf = line[header.index('name_full_furigana')].try(:split, " ").try(:[], 1)
      party_id_buf = Party.where(short_name: line[header.index('pary_id')]).first

      # 選挙区テーブルからIDを取得
      pref_code_buf = line[header.index('pref_code')].present? ? sprintf("%02d", line[header.index('pref_code')]) : nil
      senkyoku_id_buf = Senkyoku.where(pref_code: pref_code_buf, senkyoku_no: line[header.index('senkyoku_no')]).first
      gender_buf =

      case line[header.index('gender')]
      when "男性"
        gender_buf = 1
      when "女性"
        gender_buf = 2
      else
      end


      is_candidate_buf = line[header.index('is_candidate')] == '確定' ? true : false


      case line[header.index('current_position')]
        when '現'
          current_position_buf = 1
        when '新'
          current_position_buf = 2
        when '元'
          current_position_buf = 3
        else
      end


      hireiku_name = line[header.index('hirei_area_id')]
      unless hireiku_name.blank?
        hirei_area_id_buf = HireiSenkyoku.where("name LIKE (?)", "%#{hireiku_name}%").first.try(:id) || nil
      else
        hirei_area_id_buf = nil
      end


      # テーブルデータ登録
      begin
        candidate = Candidate.find_or_initialize_by(wikidata_id: wikidata_id_buf)
        candidate.update_attributes!(
          wikidata_id: wikidata_id_buf,
          name_last: line[header.index('name_last')],
          name_first: line[header.index('name_first')],
          name_last_furigana: name_last_furigana_buf,
          name_first_furigana: name_first_furigana_buf,
          party_id: party_id_buf.try(:id),
          senkyoku_id: senkyoku_id_buf.try(:id),
          gender: gender_buf,
          birth_day: line[header.index('birth_day')],
          birth_year: line[header.index('birth_year')],
          twitter_id: line[header.index('twitter_id')],
          facebook_id: line[header.index('facebook_id')],
          official_website_url: line[header.index('offiicial_website_url')],
          is_candidate: is_candidate_buf,
          current_position: current_position_buf,
          submission_order: line[header.index('submission_order')],
          hirei_area_id: hirei_area_id_buf,
          winning_history: line[header.index('winning_history')]
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
