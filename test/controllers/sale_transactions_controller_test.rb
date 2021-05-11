require "test_helper"

class SaleTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale_transaction = sale_transactions(:one)
  end

  test "should get index" do
    get sale_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_transaction_url
    assert_response :success
  end

  test "should create sale_transaction" do
    assert_difference('SaleTransaction.count') do
      post sale_transactions_url, params: { sale_transaction: { Date: @sale_transaction.Date, decimal: @sale_transaction.decimal, total_amount: @sale_transaction.total_amount, total_line_item: @sale_transaction.total_line_item, total_quantity: @sale_transaction.total_quantity, transaction_date: @sale_transaction.transaction_date, transaction_id: @sale_transaction.transaction_id } }
    end

    assert_redirected_to sale_transaction_url(SaleTransaction.last)
  end

  test "should show sale_transaction" do
    get sale_transaction_url(@sale_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_transaction_url(@sale_transaction)
    assert_response :success
  end

  test "should update sale_transaction" do
    patch sale_transaction_url(@sale_transaction), params: { sale_transaction: { Date: @sale_transaction.Date, decimal: @sale_transaction.decimal, total_amount: @sale_transaction.total_amount, total_line_item: @sale_transaction.total_line_item, total_quantity: @sale_transaction.total_quantity, transaction_date: @sale_transaction.transaction_date, transaction_id: @sale_transaction.transaction_id } }
    assert_redirected_to sale_transaction_url(@sale_transaction)
  end

  test "should destroy sale_transaction" do
    assert_difference('SaleTransaction.count', -1) do
      delete sale_transaction_url(@sale_transaction)
    end

    assert_redirected_to sale_transactions_url
  end
end
