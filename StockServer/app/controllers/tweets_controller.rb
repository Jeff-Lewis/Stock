class TweetsController < ApplicationController
  protect_from_forgery

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/new
  # GET /tweets/new.json
  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(params[:tweet])

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


  def getNextTweetsByStock
    stockId = params[:stockId]
    date = params[:date]
    num = params[:num] || 30
    getTweetsByStockHelper 'created_at > ? and stock_id = ?', stockId, date, num
  end

  def getPreviousTweetsByStock
    stockId = params[:stockId]
    date = params[:date]
    num = params[:num] || 30
    getTweetsByStockHelper 'created_at < ? and stock_id = ?', stockId, date, num
  end

  def getTweetsByStockHelper query, stockId, date, num
    #erdateId = params[:erdateId]
    #date = params[:date]
    #num = params[:num].to_i() || 30

    @result = false

    @tweets = []

    begin
      @tweets = Tweet.where(query,
                            DateTime.strptime(date, '%Y%m%d %H%M%S'),
                            stockId).order('created_at desc').limit(num)

      @result = true
    rescue
      puts "Error #{$!}"
      puts "get tweets by stock " + stockId
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Tweets were successfully retrieved."
        @message = "Tweets were successfully retrieved."
        @data = @tweets.to_json.html_safe
        format.html
        format.json { render :partial => "tweets/getTweets.json" }
      else
        flash[:error] = "Tweets failed to be retrieved."
        @message = "Tweets failed to be retrieved."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def getNextTweetsByEr
    erdateId = params[:erdateId]
    date = params[:date]
    num = params[:num] || 30
    getTweetsByErHelper 'created_at > ? and erdate_id = ?', erdateId, date, num
  end

  def getPreviousTweetsByEr
    erdateId = params[:erdateId]
    date = params[:date]
    num = params[:num] || 30
    getTweetsByErHelper 'created_at < ? and erdate_id = ?', erdateId, date, num
  end

  def getTweetsByErHelper query, erdateId, date, num
    #erdateId = params[:erdateId]
    #date = params[:date]
    #num = params[:num].to_i() || 30

    @result = false

    @tweets = []

    begin
      @tweets = Tweet.where(query,
                            DateTime.strptime(date, '%Y%m%d %H%M%S').utc.iso8601,
                            erdateId).order('created_at desc').limit(num)

      @result = true
    rescue
      puts "Error #{$!}"
      puts "get tweets by erdate " + erdateId
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Tweets were successfully retrieved."
        @message = "Tweets were successfully retrieved."
        format.html
        format.json { render :partial => "tweets/getTweets.json" }
      else
        flash[:error] = "Tweets failed to be retrieved."
        @message = "Tweets failed to be retrieved."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def createTweetByEr
    erdateId = params[:erdateId]
    content = params[:content]

    @result = false
    if !current_user.nil? && !erdateId.nil? &&
        !content.nil? && !content.blank?

      begin
        erdate = Erdate.find(erdateId)

        if !erdate.nil?
          tweet = Tweet.new()
          tweet.user = current_user
          tweet.erdate = erdate
          tweet.stock = erdate.stock
          tweet.content = content
          tweet.save()
          @result = true
        end

      rescue
        puts "Error #{$!}"
        puts current_user.id + " create tweet for erdate " + erdateId
      end
    end

    @tweets = []

    if (!erdate.nil?)
      @tweets = erdate.tweets
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Tweet was successfully created."
        @message = "Tweet was successfully created."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Tweet failed to be created."
        @message = "Tweet failed to be created."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  def createTweetByStock
    stockId = params[:stockId]
    content = params[:content]

    @result = false
    if !current_user.nil? && !stockId.nil? &&
        !content.nil? && !content.blank?

      begin
        stock = Stock.find(stockId)

        if !stock.nil?
          tweet = Tweet.new()
          tweet.user = current_user
          tweet.stock = stock
          tweet.content = content
          tweet.save()
          @result = true
        end

      rescue
        puts "Error #{$!}"
        puts current_user.id + " create tweet for stock " + stockId
      end
    end

    @tweets = []

    if (!stock.nil?)
      @tweets = stock.tweets
    end

    respond_to do |format|
      if @result
        flash[:notice] = "Tweet was successfully created."
        @message = "Tweet was successfully created."
        format.html
        format.json { render :partial => "layouts/show.json" }
      else
        flash[:error] = "Tweet failed to be created."
        @message = "Tweet failed to be created."
        format.html
        format.json { render :partial => "layouts/show.json", status: :unprocessable_entity }
      end
    end
  end

  # PUT /tweets/1
  # PUT /tweets/1.json
  def update
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      if @tweet.update_attributes(params[:tweet])
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end
end
