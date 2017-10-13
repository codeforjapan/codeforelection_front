class SearchController < ApplicationController

  def new
    @title = "トップページ"
  end

  def index
  end

  def show
    _zip_code = search_params[:zip_code]
    @senkyoku = ZipCode.where("zip_code LIKE (?)", _zip_code[0..2]).first.senkyokus.first ||
      ZipCode.where("zip_code LIKE (?)", _zip_code).first.senkyoku.senkyokus.first

    @title = "#{@senkyoku.name}の候補者一覧"
  end

  def by_name
    @keyword = params[:keyword]
    tokens = @keyword.scan(/\p{hiragana}+|\p{katakana}+|\p{Han}+|[A-Za-z]+/)
    last_like = like_escape(tokens.first || '') + '%'
    first_like = like_escape((tokens[1..-1] || []).join('')) + '%'

    @candidates = Candidate.where(
      '(name_last LIKE ? OR name_last_furigana LIKE ?)' +
      ' AND (name_first LIKE ? OR name_first_furigana LIKE ?)',
      last_like, last_like, first_like, first_like
    ).order('submission_order ASC').limit(100).to_a

    @title = "#{@keyword}の検索結果一覧"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:zip_code)
    end

    def like_escape(str)
      # http://d.hatena.ne.jp/teracc/20090703/1246576620
      str.gsub(/([\\%_])/, '\\\\\\1')
    end

end
