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


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:zip_code)
    end

end
