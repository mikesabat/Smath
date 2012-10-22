class StocksController < ApplicationController
  def new
    @stock = Stock.new
    #3.times { @stock.quotes.build }
  end

  def create
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, :notice => 'Stock was successfully created.' }
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
end