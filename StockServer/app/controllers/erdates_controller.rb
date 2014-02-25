class ErdatesController < ApplicationController
  # GET /erdates
  # GET /erdates.json
  def index
    @erdates = Erdate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @erdates }
    end
  end

  # GET /erdates/1
  # GET /erdates/1.json
  def show
    @erdate = Erdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @erdate }
    end
  end

  # GET /erdates/new
  # GET /erdates/new.json
  def new
    @erdate = Erdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @erdate }
    end
  end

  # GET /erdates/1/edit
  def edit
    @erdate = Erdate.find(params[:id])
  end

  # POST /erdates
  # POST /erdates.json
  def create
    @erdate = Erdate.new(params[:erdate])

    respond_to do |format|
      if @erdate.save
        format.html { redirect_to @erdate, notice: 'Erdate was successfully created.' }
        format.json { render json: @erdate, status: :created, location: @erdate }
      else
        format.html { render action: "new" }
        format.json { render json: @erdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /erdates/1
  # PUT /erdates/1.json
  def update
    @erdate = Erdate.find(params[:id])

    respond_to do |format|
      if @erdate.update_attributes(params[:erdate])
        format.html { redirect_to @erdate, notice: 'Erdate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @erdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /erdates/1
  # DELETE /erdates/1.json
  def destroy
    @erdate = Erdate.find(params[:id])
    @erdate.destroy

    respond_to do |format|
      format.html { redirect_to erdates_url }
      format.json { head :no_content }
    end
  end
end
