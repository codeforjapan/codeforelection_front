class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show]

  def show
  end

  private
    def set_candidate
      @candidate = Candidate.find_by(wikidata_id: candidate_params[:id])
    end
    def candidate_params
      params.permit(:id)
    end

end
