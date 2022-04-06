class API::V1::TicketTypesController < APIController
  before_action :set_ticket_type, only: [:show, :update, :destroy]

  # GET /api/v1/ticket_types
  def index
    # TODO: uncomment after creating API::V1::EventsController
    @ticket_types = TicketType.where(event_id: params[:event_id])
    #@ticket_types = TicketType.all # TODO: Comment
  end

  # GET /api/v1/ticket_types/:id
  def show
  
  end

  # POST /api/v1/ticket_types
  def create
    @ticket_type = TicketType.new(ticket_type_params)
    @ticket_type.event = Event.find(params[:event_id])

    if @ticket_type.save
      render :show, status: :created, location: @ticket_type
    else
      render json: @ticket_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1ticket_types/1
  def update
    if @ticket_type.update(ticket_type_params)
      render :show, status: :ok, location: api_v1_ticket_types_path(@ticket_type)
    else
      render json: @ticket_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1ticket_types/1
  def destroy
    @ticket_type.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_type
      @ticket_type = TicketType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_type_params
      params.fetch(:ticket_type, {}).permit(:id, :event_id, :name, :ticket_price, :description)
    end
end
