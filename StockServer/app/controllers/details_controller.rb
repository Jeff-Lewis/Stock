require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'yahoofinance'

class DetailsController < ApplicationController
  @NA = "N/A"

  # GET /details
  # GET /details.json
  def index
    @details = Detail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @details }
    end
  end

  # GET /details/1
  # GET /details/1.json
  def show
    @detail = Detail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @detail }
    end
  end

  # GET /details/new
  # GET /details/new.json
  def new
    @detail = Detail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @detail }
    end
  end

  # GET /details/1/edit
  def edit
    @detail = Detail.find(params[:id])
  end

  # POST /details
  # POST /details.json
  def create
    @detail = Detail.new(params[:detail])

    respond_to do |format|
      if @detail.save
        format.html { redirect_to @detail, notice: 'Detail was successfully created.' }
        format.json { render json: @detail, status: :created, location: @detail }
      else
        format.html { render action: "new" }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def retrieve
    count = Stock.all.count
    progress = 0.0
    Stock.all.each do |stock|
      tempProgress = stock.id.to_f() / count
      if (tempProgress - progress > 0.01)
        progress = tempProgress
        puts progress
      end

      begin
      sleep(0.2)
      puts stock.inspect
      updateDetail stock
      rescue
        puts "Error #{$!}"
        puts stock.inspect
      end
    end
  end

  def updateDetail stock
    sqt = getSimpleDetailHelper(stock.symbol)
    qt = getDetailHelper(stock.symbol)

    if stock.exchange.nil?
      exchangeName = qt.stockExchange

      exchange = nil
      if Exchange.find_by_name(exchangeName).blank?
        exchange = Exchange.new()
        exchange.name = exchangeName
        exchange.save
      else
        exchange = Exchange.find_by_name(exchangeName)
      end

      exchange.stocks << stock
    end

    detail = nil
    if stock.detail.nil?
      detail = Detail.new()
      detail.stock = stock
    else
      detail = stock.detail
    end

    if (sqt.averageDailyVolume != @NA)
      detail.avgVol = sqt.averageDailyVolume.to_f()
    end

    if (qt.dividendYield != @NA)
      detail.divYield = qt.dividendYield.to_f()
    end

    if (qt.epsEstimateCurrentYear != @NA)
      detail.eps = qt.epsEstimateCurrentYear.to_f()
    end

    if (qt.marketCap != @NA)
      detail.marketCap = qt.marketCap
    end

    if (qt.peRatio != @NA)
      detail.pe = qt.peRatio.to_f()
    end

    if (qt.weeks52Range != @NA)
      detail.yearMax = qt.weeks52Range.split(" - ")[0].to_f()
      detail.yearMin = qt.weeks52Range.split(" - ")[1].to_f()
    end

    detail.save()
  end

  def getSimpleDetailHelper symbol
    detail = nil
    quotes = YahooFinance::get_standard_quotes( symbol )
    quotes.each do |symbol, qt|
      #puts "QUOTING: #{symbol}"
      #puts qt.to_s

      detail = qt
    end

    detail
  end

  def getDetailHelper symbol
    detail = nil
    quotes = YahooFinance::get_extended_quotes( symbol )
    quotes.each do |symbol, qt|
      #puts "QUOTING: #{symbol}"
      #puts qt.to_s

      detail = qt
    end

    detail
  end

  # PUT /details/1
  # PUT /details/1.json
  def update
    @detail = Detail.find(params[:id])

    respond_to do |format|
      if @detail.update_attributes(params[:detail])
        format.html { redirect_to @detail, notice: 'Detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /details/1
  # DELETE /details/1.json
  def destroy
    @detail = Detail.find(params[:id])
    @detail.destroy

    respond_to do |format|
      format.html { redirect_to details_url }
      format.json { head :no_content }
    end
  end
end
