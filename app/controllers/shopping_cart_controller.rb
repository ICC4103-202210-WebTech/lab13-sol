class ShoppingCartController < ApplicationController
  # GET /shopping_cart/1
  # GET /shopping_cart/1.json
  def show
    @items = []
    @total = 0
    begin
      contents = get_cart_items

      # Traverse keys (ticket type IDs)
      contents.each_key do |k|
        # Amount of tickets per ticket type
        tt = TicketType.includes(:event).find(k)
        amount = contents[k]
        @items << { ticket_type: tt, amount: amount, total_price: amount*tt.price }
        @total += amount*tt.price
      end
    rescue => e
      # Log the error and redirect back to the referer
      logger.error("[ShoppingCartController#show] Unable to display shopping cart items.\nClass:#{e.class}\nError:#{e.message}\nBacktrace: #{e.backtrace.join('\n')}")
      flash[:alert] = "Failed to display shopping cart items"
      redirect_back(fallback_location: root_path)
    end
  end

  def add
    begin
      contents = get_cart_items

      # Attempt to find the required ticket type
      ttid = params[:ticket_type_id]
      TicketType.find(ttid)

      # If no tickets of the given type have been added
      unless contents.has_key?(ttid)
        # Add the first one
        contents[ttid] = 1
      else
        # Otherwise, increment the ticket count
        contents[ttid] += 1
      end

      update_cart(contents)

      # Always redirect back to the referer
      flash[:notice] = "Ticket added to the shopping cart!"
      redirect_back(fallback_location: root_path)
    rescue
      # Log the error and redirect back to the referer
      logger.error("[ShoppingCartController#add] Unable to add item to shopping cart")
      flash[:alert] = "Failed to add an item to the shopping cart"
      redirect_back(fallback_location: root_path)
    end
  end

  def remove
    begin
      contents = get_cart_items
      ttid = params[:ticket_type_id]

      unless contents.has_key?(ttid)
        raise Exception("[ShoppingCartController#show] Unable to remove item from shopping cart")
      end

      contents[ttid] -= 1
      if contents[ttid] == 0
        contents.delete(ttid)
      end

      update_cart(contents)

      flash[:notice] = "Item removed"
      redirect_back(fallback_location: root_path)

    rescue
      flash[:alert] = "Failed to remove ticket from the shopping cart"
      redirect_back(fallback_location: root_path)
    end
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

  def update_cart(items)
    cookies[shopping_cart_cookie] = JSON.generate(items)
  end

  def shopping_cart_cookie
    cart_name = "#{current_user.email}_shopping_cart"
    return cart_name
  end

  def get_cart_items
    cart = {}
    if cookies.has_key?(shopping_cart_cookie)
      cart = JSON.parse(cookies[shopping_cart_cookie])
    else
      update_cart({})
    end
    cart
  end
end
