class BeatMissesController < ApplicationController
  # GET /beat_misses
  # GET /beat_misses.json
  def index
    @beat_misses = BeatMiss.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beat_misses }
    end
  end

  # GET /beat_misses/1
  # GET /beat_misses/1.json
  def show
    @beat_miss = BeatMiss.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beat_miss }
    end
  end

  # GET /beat_misses/new
  # GET /beat_misses/new.json
  def new
    @beat_miss = BeatMiss.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beat_miss }
    end
  end

  # GET /beat_misses/1/edit
  def edit
    @beat_miss = BeatMiss.find(params[:id])
  end

  # POST /beat_misses
  # POST /beat_misses.json
  def create
    @beat_miss = BeatMiss.new(params[:beat_miss])

    respond_to do |format|
      if @beat_miss.save
        format.html { redirect_to @beat_miss, notice: 'Beat miss was successfully created.' }
        format.json { render json: @beat_miss, status: :created, location: @beat_miss }
      else
        format.html { render action: "new" }
        format.json { render json: @beat_miss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beat_misses/1
  # PUT /beat_misses/1.json
  def update
    @beat_miss = BeatMiss.find(params[:id])

    respond_to do |format|
      if @beat_miss.update_attributes(params[:beat_miss])
        format.html { redirect_to @beat_miss, notice: 'Beat miss was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beat_miss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beat_misses/1
  # DELETE /beat_misses/1.json
  def destroy
    @beat_miss = BeatMiss.find(params[:id])
    @beat_miss.destroy

    respond_to do |format|
      format.html { redirect_to beat_misses_url }
      format.json { head :no_content }
    end
  end
end
