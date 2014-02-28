require 'rubygems'
require 'nokogiri'
require 'open-uri'

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

  def parse
    100.times do |n|
      time = Time.now + 100.day + n.day
      puts time.strftime('%Y%m%d')

      sleep(1)

      begin
      page = Nokogiri::HTML(open("http://biz.yahoo.com/research/earncal/" + time.strftime('%Y%m%d') + ".html"))
      @tr = page.xpath("//tr[td/a[contains(@href, 's=')]]")
      @tr.each do |elem|
        #puts "#{elem} \n-----------\n"
        stock = Stock.new
        stock.name = elem.css('td')[0].text
        stock.symbol = elem.css('td')[1].text
        time_str = elem.css('td')[2].text

        if Stock.find_by_symbol(stock.symbol).blank?
          stock.save
        else
          stock = Stock.find_by_symbol(stock.symbol)
        end

        erdate_exists = Erdate.where('stock_id = ? and  datetime >= ?',
                                     stock.id,
                                     DateTime.strptime(time.strftime('%Y%m%d'), '%Y%m%d'))
        #erdate_exists = Erdate.where('stock_id = ?', stock.id)
        if erdate_exists.blank?
          erdate = Erdate.new()
          erdate.stock = stock
          erdate.datetime = DateTime.strptime(time.strftime('%Y%m%d'), '%Y%m%d')
          erdate.save
        end

        #stock.erdates.each do |erdate|
        #  puts erdate.stock.name + "\t" + erdate.datetime.to_s()
        #end
      end

      rescue
        puts "Error #{$!}"
        puts "http://biz.yahoo.com/research/earncal/" + time.strftime('%Y%m%d') + ".html"
      end

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Stock.all }
      format.xml { render xml: Stock.all }
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
