class PrefsController < ApplicationController

  def show
    @pref = Pref.where(pref_code: pref_params[:pref_code]).first
    @title = "#{@pref.name}の選挙区"
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pref_params
      params.permit(:pref_code)
    end

end
