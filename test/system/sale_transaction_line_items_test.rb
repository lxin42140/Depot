require "application_system_test_case"

class SaleTransactionLineItemsTest < ApplicationSystemTestCase
  setup do
    @sale_transaction_line_item = sale_transaction_line_items(:one)
  end

  test "visiting the index" do
    visit sale_transaction_line_items_url
    assert_selector "h1", text: "Sale Transaction Line Items"
  end

  test "creating a Sale transaction line item" do
    visit sale_transaction_line_items_url
    click_on "New Sale Transaction Line Item"

    fill_in "Decimal", with: @sale_transaction_line_item.decimal
    fill_in "Item", with: @sale_transaction_line_item.item_id
    fill_in "Quantity", with: @sale_transaction_line_item.quantity
    fill_in "Subtotal", with: @sale_transaction_line_item.subtotal
    click_on "Create Sale transaction line item"

    assert_text "Sale transaction line item was successfully created"
    click_on "Back"
  end

  test "updating a Sale transaction line item" do
    visit sale_transaction_line_items_url
    click_on "Edit", match: :first

    fill_in "Decimal", with: @sale_transaction_line_item.decimal
    fill_in "Item", with: @sale_transaction_line_item.item_id
    fill_in "Quantity", with: @sale_transaction_line_item.quantity
    fill_in "Subtotal", with: @sale_transaction_line_item.subtotal
    click_on "Update Sale transaction line item"

    assert_text "Sale transaction line item was successfully updated"
    click_on "Back"
  end

  test "destroying a Sale transaction line item" do
    visit sale_transaction_line_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sale transaction line item was successfully destroyed"
  end
end
