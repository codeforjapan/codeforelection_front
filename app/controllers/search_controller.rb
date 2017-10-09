class SearchController < ApplicationController

  def index
  end

  def show
    senkyoku = Senkyoku.where("zip_code LIKE (?)", search_params[:zip_code])

    if senkyoku.count > 0
      @senkyoku = senkyoku.first
    else
      @senkyoku = Senkyoku.where("zip_code LIKE (?)", search_params[:zip_code][0..2]).first
    end

  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.permit(:zip_code)
    end

end
