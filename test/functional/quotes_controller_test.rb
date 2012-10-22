require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  setup do
    @quote = quotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quote" do
    assert_difference('Quote.count') do
      post :create, :quote => { :date => @quote.date, :day_neg1_close => @quote.day_neg1_close, :day_neg1_open => @quote.day_neg1_open, :day_zero_close => @quote.day_zero_close, :day_zero_open => @quote.day_zero_open, :prediction => @quote.prediction, :stock_id => @quote.stock_id, :win => @quote.win }
    end

    assert_redirected_to quote_path(assigns(:quote))
  end

  test "should show quote" do
    get :show, :id => @quote
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quote
    assert_response :success
  end

  test "should update quote" do
    put :update, :id => @quote, :quote => { :date => @quote.date, :day_neg1_close => @quote.day_neg1_close, :day_neg1_open => @quote.day_neg1_open, :day_zero_close => @quote.day_zero_close, :day_zero_open => @quote.day_zero_open, :prediction => @quote.prediction, :stock_id => @quote.stock_id, :win => @quote.win }
    assert_redirected_to quote_path(assigns(:quote))
  end

  test "should destroy quote" do
    assert_difference('Quote.count', -1) do
      delete :destroy, :id => @quote
    end

    assert_redirected_to quotes_path
  end
end
