require "test_helper"

class SaleTransactionLineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale_transaction_line_item = sale_transaction_line_items(:one)
  end

  test "should get index" do
    get sale_transaction_line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_transaction_line_item_url
    assert_response :success
  end

  test "should create sale_transaction_line_item" do
    assert_difference('SaleTransactionLineItem.count') do
      post sale_transaction_line_items_url, params: { sale_transaction_line_item: { decimal: @sale_transaction_line_item.decimal, item_id: @sale_transaction_line_item.item_id, quantity: @sale_transaction_line_item.quantity, subtotal: @sale_transaction_line_item.subtotal } }
    end

    assert_redirected_to sale_transaction_line_item_url(SaleTransactionLineItem.last)
  end

  test "should show sale_transaction_line_item" do
    get sale_transaction_line_item_url(@sale_transaction_line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_transaction_line_item_url(@sale_transaction_line_item)
    assert_response :success
  end

  test "should update sale_transaction_line_item" do
    patch sale_transaction_line_item_url(@sale_transaction_line_item), params: { sale_transaction_line_item: { decimal: @sale_transaction_line_item.decimal, item_id: @sale_transaction_line_item.item_id, quantity: @sale_transaction_line_item.quantity, subtotal: @sale_transaction_line_item.subtotal } }
    assert_redirected_to sale_transaction_line_item_url(@sale_transaction_line_item)
  end

  test "should destroy sale_transaction_line_item" do
    assert_difference('SaleTransactionLineItem.count', -1) do
      delete sale_transaction_line_item_url(@sale_transaction_line_item)
    end

    assert_redirected_to sale_transaction_line_items_url
  end
end
