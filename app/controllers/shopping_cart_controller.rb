class ShoppingCartController < ApplicationController
  # GET /shopping_cart/1
  # GET /shopping_cart/1.json
  def show
    @items = []
    @total = 0

    # The following Will simply redirect to the referer,
    # or to the root path as fallback location.
    # redirect_back(fallback_location: root_path)
  end

  def add
    # Puts a message in the flash
    flash[:alert] = "Could not add ticket to the shopping cart!"

    # Will simply redirect to the referer, or to
    # the root path as fallback location.
    redirect_back(fallback_location: root_path)
  end

  def remove
    flash[:alert] = "Could not remove ticket from the shopping cart!"
    redirect_back(fallback_location: root_path)
  end

  def zap
    # If there is a shopping cart cookie available
    if cookies.has_key?(:shopping_cart)
      # delete it
      cookies.delete(:shopping_cart)
    end
    # Redirect to the referer or root path
    redirect_back(fallback_location: root_path)
  end

  private

  # This will serialize the current cart state
  # and store it in the cookie
  def update_cart(items)
    cookies[:shopping_cart] = JSON.generate(items)
  end

  # This will de-serialize the current cart state
  # from the cookie store and return it
  def get_cart_items
    cart = {}
    if cookies.has_key?(:shopping_cart)
      cart = JSON.parse(cookies[:shopping_cart])
    else
      update_cart({})
    end
    cart
  end
end
