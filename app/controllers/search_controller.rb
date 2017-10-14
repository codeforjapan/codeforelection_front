class SearchController < ApplicationController

  def new
    @title = APP_SUB_TITLE
  end

  def index
  end

  def show
    _zip_code = params[:zip_code].gsub(/\D/, "")
    @senkyoku = ZipCode.where("zip_code LIKE ?", "#{_zip_code}%").first.senkyokus.first
    @title = "#{@senkyoku.name}の候補者一覧"
  end

  def by_name
    @keyword = params[:keyword]
    tokens = @keyword.scan(/\p{hiragana}+|\p{katakana}+|\p{Han}+|[A-Za-z]+/)
    last_name = tokens.first || ''
    first_name = (tokens[1..-1] || []).join('')

    if @keyword.blank?
      query = Candidate.all
    elsif first_name.blank?
      query = Candidate.single_name_search(last_name)
    else
      query = Candidate.pair_name_search(last_name, first_name)
    end
    @candidates = query.order('submission_order ASC').limit(100).to_a

    @title = "#{@keyword}の検索結果一覧"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:zip_code)
    end

end
