class PositionsController < ApplicationController
  protect_from_forgery :except => [:createOrUpdate, :getPositionsByMapID]
  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @positions }
      format.xml { render xml: @positions }
    end
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position }
      format.xml { render xml: @position }
    end
  end

  # GET /positions/new
  # GET /positions/new.json
  def new
    @position = Position.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position }
      format.xml { render xml: @position }
    end
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end

  def createOrUpdatePage
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # createOrUpdatePage.html.erb
      format.json { render json: @position }
      format.xml { render xml: @position }
    end
  end

  # POST /createOrUpdate
  # POST /createOrUpdate.xml
  # POST /createOrUpdate.json
  def createOrUpdate
    user = User.find_by_phoneID params[:phoneID]
    pos = Position.where("user_id = ? AND map_id = ?", user.id, params[:mapID])

    if pos != nil and pos[0] != nil
      puts pos[0]
      pos = pos[0]
      respond_to do |format|
        if pos.update_attributes(:x => params[:x], :y => params[:y])
          format.html { redirect_to pos, notice: 'position was successfully updated.' }
          format.json { render json: pos}
          format.xml { render xml: pos}
        else
          format.html { render action: "new" }
          format.json { render json: pos.errors, status: :unprocessable_entity }
          format.xml { render xml: pos.errors, status: :unprocessable_entity }
        end
      end
    else
      pos = Position.create(user_id: user.id, map_id: params[:mapID], x: params[:x], y: params[:y])
      respond_to do |format|
        if pos.save
          format.html { redirect_to pos, notice: 'User was successfully created.' }
          format.json { render json: pos, status: :created, location: pos }
          format.xml { render xml: pos, status: :created, location: pos }
        else
          format.html { render action: "new" }
          format.json { render json: pos.errors, status: :unprocessable_entity }
          format.xml { render xml: pos.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def getPositionsByMapID
    @positions = Position.where('map_id = ?', params[:id])

    respond_to do |format|
      format.xml  { render xml: @positions.to_xml(:include => :user) }
    end
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        format.html { redirect_to @position, notice: 'Position was successfully created.' }
        format.json { render json: @position, status: :created, location: @position }
        format.xml { render xml: @position, status: :created, location: @position }
      else
        format.html { render action: "new" }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.xml { render xml: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.json
  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.xml { render xml: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end
end
