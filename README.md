# Solution to Lab Assignment #9

## Introduction

In this lab assignment you will add a working shopping cart to the Ticket Shop using a cookie, and add an image attachment to the `Event` model. You may continue to work in pairs.

## Pre-requisites

1. Study web forms in Rails as introduced in class 7, and further explained at the beginning of class 8.
2. Study about the use of session, cookies and the flash as described in class 8.
3. Study how to use Active Storage, as described in class 8 and in the Rails Guides.

## Another ungraded walk in the park

1. See the routes for the application located at `config/routes.rb`. You will notice that non-restful routes have
been added to implement a shopping cart. The `add` route will allow adding an item (ticket) to the shopping cart,
while the `remove` action is intended to remove a ticket from the shopping cart. There is a third action called `zap`
which is intended for you to use for debugging purposes. Call it with GET or POST and it will delete shopping cart 
contents. 
2. See `app/controllers/shopping_cart_controller.rb` and look at the corresponding `add`, `remove` and `zap`
actions. In addition, you will see in the private section of the controller `update_cart` and `get_cart_items` methods, 
that will serialize/deserialize shopping cart state to/from a cookie. Cookie entries only store strings, therefore,
in order to store a hash in a cookie, some form of serialization is needed allowing to store the data as a plain
string. In this case, it was chosen to serialize data as JSON. There are two functions provided by the JSON module for 
this: `parse`, which will take a string an return an object (a hash), and `generate`, which takes a hash and returns a 
string with its serialization. 
3. The `ShoppingCartController#show` action is intended to generate an array containing entries that are necessary
for rendering a view (i.e., the view in `app/views/shopping_cart/show.html.erb`) listing the shopping cart's contents. 
The view contains a table. The header row of the table will allow you to notice the information you will need to gather 
in the `@items` and `@total` variables in `ShoppingCartController#show` in order to display in each row of the table.
4. There is a helper function in `app/helpers/application_helper.rb` called `cart_item_count` that allows obtaining the 
number of items currently in the shopping cart, which is invoked in the application layout:
5. See the application layout located at `app/views/layouts/application.html.erb`. See the placeholders
for the shopping cart, as well as for displaying `notice` and `alert` messages.
6. In order to support images in `Event` records, Active Storage has been already configured for use in the application.
You may see the related configuration in `config/environments/development.rb` and `config/storage.yml`.
7. See the partial at `views/events/_form.html.erb`. This partial is shared by the new and edit views of events, and
provides a form through which is possible to enter/edit event information as well as information for the first
ticket type for the event, through nested fields. Validation has been enabled for this form, i.e., attempt 
to leave fields empty or enter invalid data in them and see the error messages that appear when submitting the form.
8. See the view at `views/events/show.html.erb`. Notice that in the table that displays the available ticket types, an
`Add to Cart` button is added to each entry. Look at the parameters with which `link_to` is being called.

## Test your might!

1. [1 point] Modify the `Event` model so that it allows attaching a file. Name the corresponding field `flyer`.
Modify `EventsController` so that the `flyer` parameter is allowed when creating or updating an `Event` record. Finally,
add a form label and file field to the form partial at `views/events/_form.html.erb`, in order to upload a flyer image. 
Style the fields with appropriate Bootstrap styles.
2. [0.5 point] Modify the partial located at `views/events/_event_tile.html.erb`, so that if the `Event` model has a `flyer` 
attached the corresponding image is displayed instead of the generic placeholder `thumbnail.svg`. Otherwise, just have 
the tile display the generic placeholder. Hint: use the `attached?` method in order to check whether the `Event` model 
has a `flyer` file attached or not. The flyer image should not be larger than 400 pixels wide when displayed, i.e., 
when displaying a flyer generate an image variant 400px wide in order to fulfill this.
3. [0.5 point] Modify the view at `views/events/show.html.erb` so that it shows the event below the heading. The image
should be displayed 400px wide. When the user clicks on the image, have a Bootstrap modal window open displaying the 
image 800px wide. For an example on this, take a look at the 
[large modal](https://getbootstrap.com/docs/5.1/components/modal/) example (see "Optional Sizes" section). 
3. [1 point] Complete the `ShoppingCartController#add` action allowing to add a ticket to the shopping cart. For this, consider
that tickets are stored in the shopping cart by means of a hash. The keys are the ids of the `TicketType`s chosen, while
the values are the amount of each `TicketType`. So, when adding a ticket to the shopping cart you will need to either
add a new entry initialized with value 1, in case it is the first ticket that has been added of the given `TicketType`,
or increase the count, in case there was already an entry for the required `TicketType`. You should handle
errors that may occur. For this, it is recommended to use exception handling in your action (`begin-rescue`). If the 
action fails for any reason, you should put an appropriate `alert` message in the flash, and redirect the user to the 
referrer, that is, use the `redirect_back` method, passing the `fallback_location: root_path` parameter in case the 
referrer cannot be resolved. In case it is possible to add the ticket to the cart, put a `notice` message
in the flash, telling the user that the ticket could be added. 
4. [1 point] Complete the `ShoppingCartController#remove` action which must remove a ticket from the shopping cart. For this, you
need to find the matching `TicketType` entry in the hash stored in the shopping cart, and decrease the count. As in the
`add` action, you need to handle exceptions that may occur. Give the user an error message and avoid the application 
crashing!
5. [1 point] Complete the `ShoppingCartController#show` action so that it displays the shopping cart contents in its table. Note
that the table must show the total amount of tickets being purchased, as well as the total order price. As described
before, you will need to complete `ShoppingCartController#show` so that the `@items` list and `@total` attributes 
contain the data that is necessary to display the view. 
6. [1 point] Each entry listed in the table at `ShoppingCartController#show` should provide a button that allows removing one 
ticket at a time. For this, you may use a standard button, or try a [FontAwesome](https://fontawesome.com/) icon. 
FontAwesome is a is a font and icon toolkit that has been 
[installed in the project](https://stackoverflow.com/questions/71430573/can-font-awesome-be-used-with-importmaps-in-rails-7) and
is widely used in web applications. When count of any TicketType reaches zero in the shopping cart, the table entry
displayed in `ShoppingCartController#show` must disappear. Use the `notice` flash variable in order to notify the user
that a ticket has been removed.

## Grading

Each of the three parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

Please commit and push your code to GitHub until tomorrow (Wednesday 20th) at 23:59.

## Active Record reference

We leave the following sections from previous lab assignments here, in case you need to perform operations with Active Record, for any reason.

## About migrations

* Migrations that you create by using the rails generator can be modified by hand. You may do so in case you misstype column names, or types. If you need to modify a migration by hand, delete the database (run `db:drop`) (see below about database tasks), and start over recreating the database (run `db:setup`).

## The Rails Console

Ruby on Rails provides a console on which you may run ruby code that instances the models contained in your application, and allows you to try out the associations that are implemented. Just to give you an idea about what is possible, consider the following example:

```sh
rails c
> Event.all # Will show all Beer models available
> Event.first # Will show the first event record found
> ev = EventVenue.create(name: bb, capacity: 1000) # Create an event venue
> e = Event.create(...) # This will create an event
> c = Customer.create(...)
```

To quit the console, press Ctrl+D.

## Basic database tasks

Rails provides several database tasks that you may run on the command line whenever needed:

* `db:migrate` runs (single) migrations that have not run yet.
* `db:create` creates the database
* `db:drop` deletes the database
* `db:schema:load` creates tables and columns within the (existing) database following `schema.rb`
* `db:setup` does `db:create`, `db:schema:load`,  `db:seed`
* `db:reset` does `db:drop`, `db:setup`

Typically, you would use db:migrate after having made changes to the schema via new migration files (this makes sense only if there is already data in the database). `db:schema:load` is used when you setup a new instance of your app.

After you create a migration, do not forget to apply it to the database!

```sh
rails db:migrate
```

The following example will drop the current database and then recreate it, including initialization as specified in `db/seeds.rb`:

```sh
rails db:drop
rails db:setup
```

## Useful links

The following links to Rails Guides will provide you useful information for completing your assignment:

* [HTML 5 basics (W3Schools)](https://www.w3schools.com/html/html_basic.asp)
* [Layouts and Rendering in Rails](https://edgeguides.rubyonrails.org/layouts_and_rendering.html)
* [Action View Helpers](https://edgeguides.rubyonrails.org/form_helpers.html) 
* [Rails Action Controller Overview](https://edgeguides.rubyonrails.org/action_controller_overview.html) 
* [Rails Routing from the Outside In](https://edgeguides.rubyonrails.org/routing.html)
* [Command line](http://edgeguides.rubyonrails.org/command_line.html)
* [Active Record Basics](http://edgeguides.rubyonrails.org/active_record_basics.html)
* [Active Record Model](http://api.rubyonrails.org/classes/ActiveModel/Model.html)
* [Basic Models Associations](http://edgeguides.rubyonrails.org/association_basics.html)
* [Active Record Association Methods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
* [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
* [Active Record Validations](https://edgeguides.rubyonrails.org/active_record_validations.html)
* [Active Record Query Interface](https://edgeguides.rubyonrails.org/active_record_callbacks.html)
