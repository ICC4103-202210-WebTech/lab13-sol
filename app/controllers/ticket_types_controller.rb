class TicketTypesController < ApplicationController
  before_action :set_ticket_type, only: [:show, :update, :edit, :destroy]

  # GET /ticket_types
  def index
    @ticket_types = TicketType.all
  end

  # GET /ticket_types
  def new
    @event = Event.find(params[:event_id])
    @ticket_type = TicketType.new
  end

  # GET /ticket_types/1
  def show
  end

  # POST /ticket_types
  def create
    @event = Event.find(params[:event_id])
    @ticket_type = TicketType.new(ticket_type_params)
    @ticket_type.event = @event

    respond_to do |format|
      if @ticket_type.save
        format.html { redirect_to @ticket_type, notice: 'Ticket type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # GET /ticket_types/edit/1
  def edit
  end

  # PATCH/PUT /ticket_types/1
  def update
    respond_to do |format|
      if @ticket_type.update(ticket_type_params)
        format.html { redirect_to @ticket_type, notice: 'Ticket type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ticket_types/1
  def destroy
    @ticket_type.destroy
    respond_to do |format|
      format.html { redirect_to ticket_types_url, notice: 'Ticket type was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_type
      @ticket_type = TicketType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_type_params
      params.fetch(:ticket_type, {}).permit(:name, :price, :event_id)
    end
end
