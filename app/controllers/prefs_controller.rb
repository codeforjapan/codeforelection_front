class PrefsController < ApplicationController

  def show
    @pref = Pref.find_by!(pref_code: pref_params[:pref_code])
    @title = "#{@pref.name}の選挙区"
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pref_params
      params.permit(:pref_code)
    end

end
