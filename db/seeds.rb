# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

=begin
c1 = Customer.new(first_name: "John", last_name: "Doe", email: "john.doe@example.com", phone: "123123123", address: "222 Yellow Brick Road")
c2 = Customer.new(first_name: "Phillip", last_name: "Berger", email: "phillip.berger@example.com", phone: "456456456", address: "333 Elm Street")

ev1 = EventVenue.new(name: "Estadio Nacional", capacity: 50000, address: "Av. Grecia 2001, Ñuñoa, Región Metropolitana")
ev2 = EventVenue.new(name: "Estadio Monumental", capacity: 20000, address: "Marathon 5300, Macul, Región Metropolitana")
ev3 = EventVenue.new(name: "Teatro Caupolican", capacity: 3000, address: "San Diego 850, Santiago, Región Metropolitana")

e1 = Event.create(name: "Partido Colo-Colo vs. U. Chile", event_venue: ev2, description: "Super clasico", start_date: "2022-03-19 15:00", end_date: "2022-03-19 18:00")
e2 = Event.create(name: "Al Dimeola en Chile", event_venue: ev3, description: "Concierto del astro de la guitarra fusion.", start_date: "2022-05-16 20:00", end_date: "2022-05-16 22:30")

tt1 = TicketType.create(name: "Galeria", event: e1, price: 20000)
tt2 = TicketType.create(name: "Pacifico Bajo", event: e1, price: 40000)

tt3 = TicketType.create(name: "Galeria", event: e2, price: 40000)
tt4 = TicketType.create(name: "VIP", event: e2, price: 100000)

o1 = Order.create(customer: c1)
t1 = Ticket.create(ticket_type: tt1, order: o1)
t1 = Ticket.create(ticket_type: tt2, order: o1)
t1 = Ticket.create(ticket_type: tt2, order: o1)
=end
