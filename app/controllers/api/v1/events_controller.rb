class API::V1::EventsController < APIController
  before_action :set_event, only: %i[ show update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      render :show, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    if @event.update(event_params)
      render :show, status: :ok, location: @event 
    else
      render json: @event.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.fetch(:event, {}).permit(:id, :name, :description, :start_date, :end_date, :event_venue_id)
    end
end
