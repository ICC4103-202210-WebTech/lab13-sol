class ShoppingCartController < ApplicationController
  def show
    @tickets = Ticket.includes(ticket_type: :event).take(5)
  end
end
