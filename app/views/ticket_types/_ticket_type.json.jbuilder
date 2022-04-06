json.extract! ticket_type, :id, :price, :name, :event_id, :created_at, :updated_at
json.url ticket_type_url(ticket_type, format: :json)
