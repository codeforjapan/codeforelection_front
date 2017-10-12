class SenkyokusController < ApplicationController

  # GET /senkyokus/1
  # GET /senkyokus/1.json
  def show
    @senkyoku = Senkyoku.where(pref_code: senkyoku_params[:pref_code], senkyoku_no: senkyoku_params[:senkyoku_no]).first
    @title = @senkyoku.name
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def senkyoku_params
      params.permit(:pref_code, :senkyoku_no)
    end
end
