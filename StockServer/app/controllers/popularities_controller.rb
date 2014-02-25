class PopularitiesController < ApplicationController
  # GET /popularities
  # GET /popularities.json
  def index
    @popularities = Popularity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @popularities }
    end
  end

  # GET /popularities/1
  # GET /popularities/1.json
  def show
    @popularity = Popularity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @popularity }
    end
  end

  # GET /popularities/new
  # GET /popularities/new.json
  def new
    @popularity = Popularity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @popularity }
    end
  end

  # GET /popularities/1/edit
  def edit
    @popularity = Popularity.find(params[:id])
  end

  # POST /popularities
  # POST /popularities.json
  def create
    @popularity = Popularity.new(params[:popularity])

    respond_to do |format|
      if @popularity.save
        format.html { redirect_to @popularity, notice: 'Popularity was successfully created.' }
        format.json { render json: @popularity, status: :created, location: @popularity }
      else
        format.html { render action: "new" }
        format.json { render json: @popularity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /popularities/1
  # PUT /popularities/1.json
  def update
    @popularity = Popularity.find(params[:id])

    respond_to do |format|
      if @popularity.update_attributes(params[:popularity])
        format.html { redirect_to @popularity, notice: 'Popularity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @popularity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /popularities/1
  # DELETE /popularities/1.json
  def destroy
    @popularity = Popularity.find(params[:id])
    @popularity.destroy

    respond_to do |format|
      format.html { redirect_to popularities_url }
      format.json { head :no_content }
    end
  end
end
