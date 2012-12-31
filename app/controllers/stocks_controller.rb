class StocksController < ApplicationController
  def new
    @stock = Stock.new
    #3.times { @stock.quotes.build }
  end

  def track
    @positive_stock = Stock.positive_plays
    @negative_stock = Stock.negative_plays
  end

  def create
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to new_stock_quote_path(@stock), :notice => 'Stock was successfully created.' }
        format.json { render :json => @stock, :status => :created, :location => @stock }
      else
        format.html { render :action => "new" }
        format.json { render :json => @stock.errors, :status => :unprocessable_entity }
      end
    end
  end  

  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @stock }
    end
  end

  def index
    @stock = Stock.all
    @scheduled_stocks = Stock.scheduled

    respond_to do |format|
      format.html #index.html.erb
      format.json { render :json => @stock }
    end
  end

end