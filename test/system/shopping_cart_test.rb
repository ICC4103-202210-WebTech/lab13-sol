require "application_system_test_case"

class ShoppingCartTest < ApplicationSystemTestCase
  setup do
    @shopping_cart = shopping_cart(:one)
  end

  test "visiting the index" do
    visit shopping_cart_url
    assert_selector "h1", text: "Shopping carts"
  end

  test "should create shopping cart" do
    visit shopping_cart_url
    click_on "New shopping cart"

    click_on "Create Shopping cart"

    assert_text "Shopping cart was successfully created"
    click_on "Back"
  end

  test "should update Shopping cart" do
    visit shopping_cart_url(@shopping_cart)
    click_on "Edit this shopping cart", match: :first

    click_on "Update Shopping cart"

    assert_text "Shopping cart was successfully updated"
    click_on "Back"
  end

  test "should destroy Shopping cart" do
    visit shopping_cart_url(@shopping_cart)
    click_on "Destroy this shopping cart", match: :first

    assert_text "Shopping cart was successfully destroyed"
  end
end
