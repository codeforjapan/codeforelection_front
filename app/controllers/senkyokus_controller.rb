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

  # GET /senkyokus/new
  def new
    @senkyoku = Senkyoku.new
  end

  # GET /senkyokus/1/edit
  def edit
  end

  # POST /senkyokus
  # POST /senkyokus.json
  def create
    @senkyoku = Senkyoku.new(senkyoku_params)

    respond_to do |format|
      if @senkyoku.save
        format.html { redirect_to @senkyoku, notice: 'Senkyoku was successfully created.' }
        format.json { render :show, status: :created, location: @senkyoku }
      else
        format.html { render :new }
        format.json { render json: @senkyoku.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /senkyokus/1
  # PATCH/PUT /senkyokus/1.json
  def update
    respond_to do |format|
      if @senkyoku.update(senkyoku_params)
        format.html { redirect_to @senkyoku, notice: 'Senkyoku was successfully updated.' }
        format.json { render :show, status: :ok, location: @senkyoku }
      else
        format.html { render :edit }
        format.json { render json: @senkyoku.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /senkyokus/1
  # DELETE /senkyokus/1.json
  def destroy
    @senkyoku.destroy
    respond_to do |format|
      format.html { redirect_to senkyokus_url, notice: 'Senkyoku was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_senkyoku
      @senkyoku = Senkyoku.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def senkyoku_params
      params.require(:senkyoku).permit(:pref_code, :senkyoku_no, :zip_code)
    end
end
