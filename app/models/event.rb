class Event < ApplicationRecord
    belongs_to :event_venue, optional: true
    has_many :ticket_types
    has_and_belongs_to_many :organizers

    accepts_nested_attributes_for :ticket_types, allow_destroy: true
    accepts_nested_attributes_for :event_venue    
end
