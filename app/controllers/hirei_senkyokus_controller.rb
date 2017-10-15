class HireiSenkyokusController < ApplicationController

  def show
    @hirei_senkyoku = HireiSenkyoku.find_by(name: params[:name])
    @candidates = Candidate.includes(:party).where(hirei_area_id: @hirei_senkyoku.id).order('party_id, hirei_meibo_order_no').group_by {|candidate| candidate.party_id }

    @title = @hirei_senkyoku.name
  end

end
