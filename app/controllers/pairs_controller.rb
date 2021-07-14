class PairsController < ApplicationController
  before_action :set_pair, only: %i[ show edit update destroy ]

  # GET /pairs or /pairs.json
  def index
    @pairs = Pair.actives_to_day
  end

  # GET /pairs/1 or /pairs/1.json
  def show
  end

  # GET /pairs/new
  def new
    @pair = Pair.new
  end

  # GET /pairs/1/edit
  def edit
  end

  # POST /pairs or /pairs.json
  def create
    @pair = Pair.new(pair_params)

    respond_to do |format|
      if @pair.save
        format.html { redirect_to @pair, notice: "Pair was successfully created." }
        format.json { render :show, status: :created, location: @pair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pairs/1 or /pairs/1.json
  def update
    respond_to do |format|
      if @pair.update(pair_params)
        format.html { redirect_to @pair, notice: "Pair was successfully updated." }
        format.json { render :show, status: :ok, location: @pair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pairs/1 or /pairs/1.json
  def destroy
    @pair.destroy
    respond_to do |format|
      format.html { redirect_to pairs_url, notice: "Pair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add
    @players = Player.all
  end

  def generate
    @players = Player.all

    if params[:pairs_generated].present?
      pairs_params = params[:pairs_generated]
      pairs_params.map { |pair| pair[:pair_date] = Time.now }
      params.permit!
      create_pairs = Pair.create(pairs_params)
    elsif params[:players].present?
      @player_ids = params[:players].keys
      array_ids_one = @player_ids.sort_by { rand }
      array_ids_two = @player_ids.sort_by { rand }

      pair_confirmed = []
      @pairs = []

      array_ids_one.each do |one_id|
        unless pair_confirmed.include?(one_id)
          player_one = Player.find_by_id(one_id.to_i)
          array_ids_two.each do |two_id|
            next if one_id == two_id
            next if pair_confirmed.include?(one_id) || pair_confirmed.include?(two_id)
            unless player_one.pairs_one.actives.map(&:player_two_id).include?(two_id.to_i) ||
                player_one.pairs_two.actives.map(&:player_one_id).include?(two_id.to_i)
              player_two = Player.find_by_id(two_id.to_i)
              pair_confirmed << one_id
              pair_confirmed << two_id
              @pairs << { 
                          player_one_id: one_id.to_i,
                          name_one: player_one.first_name,
                          player_two_id: two_id.to_i,
                          name_two: player_two.first_name
                        }
            end
          end
        end
      end
      notice = pair_confirmed.size == 0 ? "No hay combinaciones posibles" : nil
    end

    respond_to do |format|
      if create_pairs.present? && create_pairs
        format.html { redirect_to pairs_url, notice: "Parejas creadas con exito." }
      else
        format.html { render :add, notice: notice }
        format.json { render :show, status: :created, location: @pair }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pair
      @pair = Pair.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pair_params
      params.require(:pair).permit(:player_one_id, :player_two_id, :pair_date, :status)
    end
end