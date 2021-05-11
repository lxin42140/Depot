require "application_system_test_case"

class SaleTransactionsTest < ApplicationSystemTestCase
  setup do
    @sale_transaction = sale_transactions(:one)
  end

  test "visiting the index" do
    visit sale_transactions_url
    assert_selector "h1", text: "Sale Transactions"
  end

  test "creating a Sale transaction" do
    visit sale_transactions_url
    click_on "New Sale Transaction"

    fill_in "Date", with: @sale_transaction.Date
    fill_in "Decimal", with: @sale_transaction.decimal
    fill_in "Total amount", with: @sale_transaction.total_amount
    fill_in "Total line item", with: @sale_transaction.total_line_item
    fill_in "Total quantity", with: @sale_transaction.total_quantity
    fill_in "Transaction date", with: @sale_transaction.transaction_date
    fill_in "Transaction", with: @sale_transaction.transaction_id
    click_on "Create Sale transaction"

    assert_text "Sale transaction was successfully created"
    click_on "Back"
  end

  test "updating a Sale transaction" do
    visit sale_transactions_url
    click_on "Edit", match: :first

    fill_in "Date", with: @sale_transaction.Date
    fill_in "Decimal", with: @sale_transaction.decimal
    fill_in "Total amount", with: @sale_transaction.total_amount
    fill_in "Total line item", with: @sale_transaction.total_line_item
    fill_in "Total quantity", with: @sale_transaction.total_quantity
    fill_in "Transaction date", with: @sale_transaction.transaction_date
    fill_in "Transaction", with: @sale_transaction.transaction_id
    click_on "Update Sale transaction"

    assert_text "Sale transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Sale transaction" do
    visit sale_transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sale transaction was successfully destroyed"
  end
end
