class ChirpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chirp, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @timeline = Chirp.timeline(current_user).page params[:page]
  end

  def new
    @chirp = Chirp.new
  end

  def create
    @chirp = Chirp.new(chirp_params)

    respond_to do |format|
      if @chirp.save
        format.html { redirect_to @chirp, notice: 'Chirp was successfully created.' }
        format.json { render :show, status: :created, location: @chirp }
      else
        format.html { render :new }
        format.json { render json: @chirp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chirp.destroy
    respond_to do |format|
      format.html { redirect_to chirps_url, notice: 'Chirp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_chirp
      @chirp = Chirp.find(params[:id])
    end

    def chirp_params
      params.fetch(:chirp, {})
    end
end
