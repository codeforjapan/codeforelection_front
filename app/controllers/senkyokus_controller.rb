class SenkyokusController < ApplicationController
  before_action :set_senkyoku, only: [:show, :edit, :update, :destroy]

  # GET /senkyokus
  # GET /senkyokus.json
  def index
    @senkyokus = Senkyoku.all
  end

  # GET /senkyokus/1
  # GET /senkyokus/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_senkyoku
      @senkyoku = Senkyoku.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def senkyoku_params
      params.require(:senkyoku).permit(:pref_code, :senkyoku_no)
    end
end
