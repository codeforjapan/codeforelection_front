require 'csv'

namespace :import do
  task :spreadsheet do
	conn = Faraday.new(:url => 'https://raw.githubusercontent.com') do |faraday|
	  faraday.request  :url_encoded
	  faraday.response :logger
	  faraday.adapter  Faraday.default_adapter
	end
	response = conn.get('/hkwi/shuin48pre/master/docs/gdoc_gray_db.csv')

	column_keys = []
	CSV.new(response.body).each do | row |
	  puts row[0]
	  if row[0].force_encoding("UTF-8") == "UI用DBカラム名"
		column_keys = row.map { | column | column.try(:to_sym)}.flatten
		column_keys = column_keys[1..column_keys.count].compact
	  end
	end
  end
end
