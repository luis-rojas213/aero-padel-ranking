class PlaysController < ApplicationController
  before_action :set_play, only: %i[ show edit update destroy ]

  # GET /plays or /plays.json
  def index
    @plays = Play.actives_to_day
  end

  # GET /plays/1 or /plays/1.json
  def show
  end

  # GET /plays/new
  def new
    @pairs = Pair.actives_to_day
    if @pairs.present? && @pairs.size > 1
      @play = Play.new
    else
      respond_to do |format|
        format.html { redirect_to plays_path, notice: "Debe generar parejas antes de cargar un juego" }
      end
    end
  end

  # GET /plays/1/edit
  def edit
    @pairs = Pair.actives_to_day
  end

  # POST /plays or /plays.json
  def create
    @play = Play.new(play_params)
    @play.play_date = Time.now

    respond_to do |format|
      if @play.save
        format.html { redirect_to plays_path, notice: "Juego creado con exito." }
        format.json { render :show, status: :created, location: @play }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plays/1 or /plays/1.json
  def update
    #updated_play = Play.find_by_id(@play.id)
    #updated_play.delete_ranking
    respond_to do |format|
      if @play.delete_ranking && @play.update(play_params)
        format.html { redirect_to plays_path, notice: "Juego actualizado con exito." }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1 or /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: "Juego borrado con exito." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def play_params
      params.require(:play).permit(:pair_one_id, :pair_two_id, :pair_one_point, :pair_two_point, :play_date)
    end
end
