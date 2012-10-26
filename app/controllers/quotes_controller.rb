class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index
    @stock = Stock.find(params[:stock_id])
    @quotes = Quote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @quotes }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @quote }
    end
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    #http://stackoverflow.com/questions/3305530/rails-3-nested-resources-undefined-method-error
    @stock = Stock.find(params[:stock_id])
    # creating a new quote from this advice http://stackoverflow.com/questions/3305530/rails-3-nested-resources-undefined-method-error
    # @quote = Quote.new(:stock_id => params[:stock_id])
    @quote = @stock.quotes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @quote }
    end
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote]) #@quote = Quote.new(params[:quote][:stock])
    @stock = Stock.find(params[:stock_id])

    respond_to do |format|
      if @quote.save
        #not sure why '(@stock, @quote)' is needed, but this is the second time
        format.html { redirect_to stock_quotes_path(@stock), :notice => 'Quote was successfully created.' }
        format.json { render :json => @quote, :status => :created, :location => @quote }
      else
        format.html { render :action => "new" }
        format.json { render :json => @quote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = Quote.find(params[:id])

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        format.html { redirect_to @quote, :notice => 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @quote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end
end
