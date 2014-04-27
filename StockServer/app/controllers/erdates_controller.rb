require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ErdatesController < ApplicationController
  protect_from_forgery

  @NA = "N/A"

  # GET /erdates
  # GET /erdates.json
  def index
    @erdates = Erdate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @erdates }
    end
  end

  def indexByStock
    @stock = Stock.find(params[:stockId])
    @erdates = Erdate.find_all_by_stock_id(params[:stockId])

    respond_to do |format|
      format.html # indexByStock.html.erb
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

  def parseErEst
    symbol = params[:symbol]
    date = params[:date]
    date = date.gsub("-", "/")

    puts symbol + " at " + date

    er = parseErEstHelper(symbol, date)

    @result = er[:value]
    render :partial => "layouts/show.html"
  end

  def parseErEstHelper symbol, date
    value = @NA
    est = @NA
    link = @NA
    begin

    page = Nokogiri::HTML(open("http://www.streetinsider.com/ec_earnings.php?q=" + symbol))
    tr = page.xpath("//tr[td[contains(text(), '" + date + "')]]")
    tr.each do |elem|
      #puts "#{elem} \n-----------\n"
      #11.times do |n|
      #  puts n.to_s() + " = " + elem.css('td')[n].text
      #end

      value = elem.css('td')[3].text.gsub("$", "")

      est = elem.css('td')[4].text.gsub("$", "")

      link = elem.css("a[text()='Details']")[0]['href']
      puts "#{symbol} @#{date} = est:#{est} value:#{value} link:#{link}"
    end

    rescue
      puts "Error #{$!}"
      puts "http://www.streetinsider.com/ec_earnings.php?q=" + symbol + " date at " + date
    end

    { symbol: symbol, date: date, value: value, est: est, link: link }
  end

  def parse
    days = params[:num]
    days.to_i.times do |n|
      time = Time.now - (days.to_i / 2.0).to_i.day + n.day
      #time = Time.strptime('20140221', '%Y%m%d') + n.day
      puts time.strftime('%Y%m%d')

      sleep(1)

      begin
      page = Nokogiri::HTML(open("http://biz.yahoo.com/research/earncal/" + time.strftime('%Y%m%d') + ".html"))
      @tr = page.xpath("//tr[td/a[contains(@href, 's=')]]")
      @tr.each do |elem|
        #puts "#{elem} \n-----------\n"
        sleep(0.2)

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
        erdate = nil
        if erdate_exists.blank?
          erdate = Erdate.new()
          erdate.stock = stock
          erdate.datetime = DateTime.strptime(time.strftime('%Y%m%d'), '%Y%m%d')

          erdate.save
        else
          erdate = erdate_exists.first
        end

        #update er data
        date = time.strftime('%-m/%-d') + "/" + (time.year - 2000).to_s()
        er = parseErEstHelper(stock.symbol, date)

        if (er[:est] != @NA)
          erdate.estimate = er[:est].to_f()
        end

        if (er[:value] != @NA)
          erdate.value = er[:value].to_f()
        end

        if (er[:link] != @NA)
          erdate.confcall = er[:link]
        end

        erdate.save

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

  def watchEr
    userId = params[:userId]
    erdateId = params[:erdateId]

    @result = false
    if !userId.nil? && !erdateId.nil?

      begin
      user = User.find(userId)
      erdate = Erdate.find(erdateId)

      if (!user.nil? && !erdate.nil?)
        user.watchEr!(erdate)
        @result = true
      end

      rescue
        puts "Error #{$!}"
        puts userId + " watch " + erdateId
      end
    end

    @erdates = []

    if (!user.nil?)
      @erdates = user.erdates
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Erdate was successfully watched."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Erdate failed to be watched."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def unwatchEr
    userId = params[:userId]
    erdateId = params[:erdateId]

    @result = false
    if !userId.nil? && !erdateId.nil?

      begin
        user = User.find(userId)
        erdate = Erdate.find(erdateId)

        if (!user.nil? && !erdate.nil?)
          user.unwatchEr!(erdate)
          @result = true
        end

      rescue
        puts "Error #{$!}"
        puts userId + " unwatch " + erdateId
      end
    end

    @erdates = []

    if (!user.nil?)
      @erdates = user.erdates
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Erdate was successfully unwatched."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Erdate failed to be unwatched."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def getPreviousErs
    date = params[:date]
    userId = params[:userId]
    num = params[:num] || 7
    num = num.to_i()

    begin

      @user = User.find(userId)

      @erdates = Erdate.where('datetime < ? and datetime >= ?',
                              DateTime.strptime(date, '%Y%m%d'),
                              DateTime.strptime(date, '%Y%m%d') - num.days).order('datetime asc')

    rescue
      puts "Error #{$!}"
      puts date + " user: " + userId
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "erdates/getErs.json" }
      format.xml { render :xml=> @erdates, :include => {:stock => { :include => [:popularity, :exchange] }} }
    end
  end

  def getNextErs
    date = params[:date]
    userId = params[:userId]
    num = params[:num] || 7
    num = num.to_i()

    begin

      @user = User.find(userId)

      @erdates = Erdate.where('datetime >= ? and datetime <= ?',
                                   DateTime.strptime(date, '%Y%m%d'),
                                   DateTime.strptime(date, '%Y%m%d') + num.days).order('datetime asc')

    rescue
      puts "Error #{$!}"
      puts date
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :partial => "erdates/getErs.json" }
      format.xml { render :xml=> @erdates, :include => {:stock => { :include => [:popularity, :exchange] }} }
    end
  end

  def beatEr
    userId = params[:userId]
    erdateId = params[:erdateId]

    beh = beatErHelper(userId, erdateId, true)

    @beat_misses = beh[:beat_misses]
    @result = beh[:result]
    respond_to do |format|
      if @result
        flash[:notice] = "Erdate was successfully watched."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Erdate failed to be watched."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def missEr
    userId = params[:userId]
    erdateId = params[:erdateId]

    beh = beatErHelper(userId, erdateId, false)

    @beat_misses = beh[:beat_misses]
    @result = heh[:result]
    respond_to do |format|
      if @result
        flash[:notice] = "Erdate was successfully watched."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Erdate failed to be watched."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def beatErHelper userId, erdateId, beat
    result = false
    if !userId.nil? && !erdateId.nil?

      begin
        user = User.find(userId)
        erdate = Erdate.find(erdateId)

        if (!user.nil? && !erdate.nil?)
          if (beat)
            user.beatEr!(erdate)
          else
            user.missEr!(erdate)
          end
          result = true
        end

      rescue
        puts "Error #{$!}"
        puts userId + " watch " + erdateId
      end
    end

    beat_misses = []

    if (!user.nil?)
      beat_misses = user.beat_misses
    end

    {result: result, beat_misses: beat_misses}
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
