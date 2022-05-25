# Solution to Lab Assignment #12

## Introduction

In this lab assignment you will enable access control and authentication in the Ticket Shop application. The starter code you are provided with already contains [Devise](https://github.com/heartcombo/devise) and [Cancancan](https://github.com/CanCanCommunity/cancancan) gems installed and partially configured.

You may continue to work in pairs.

## Pre-requisites

* It is highly recommendable that you skim through [Devise's](https://github.com/heartcombo/devise)
and [Cancancan's](https://github.com/CanCanCommunity/cancancan) 'Getting Started'
guides, as these will walk you through the basics of both gems.
* Follow the non-graded steps carefully so that you understand how the application works in its
initial state.

## Run the First Steps as Usual

If you use RVM then the correct version of ruby and gemset will be chosen automatically for you (`3.1.1@webtech`)
whenever you switch to the project directory on the terminal. If you need to choose this manually, then run

```sh
$rvm use 3@webtech
```

Install any missing gems and setup de database:

```sh
bundle install # new gems have been added to the Gemfile
rails db:setup
rails db:populate_fake_data # This will generate fake events, customers, etc.
rails admin:create_admin_user # This will create admin user with email admin@ticketshop.com, and with the password you enter\
rails s # Run the application with an application server
```

Note that the last command will launch an application server that will allow accessing your application from either a web browser (at [http://localhost:3000](http://localhost:3000)).

## Non-graded Steps

1. Have a look at the application layout at `app/views/layouts/application.html.erb`, and follow theHTML comments that start with 'TODO', as this are (graded) steps you are expected to complete.
2. Take a look at the following event-related views: `app/views/events/{index.html.erb,show.html.erb,_event_tile.html.erb}` You will also see TODO comments explaining what you are expected to complete.
3. Go to `app/controllers/application_controller.rb` and see the method `current_user`. Per each model to which Devise is added, Devise dynamically enables several methods matching the respective model names, such as `current_admin`, and `current_customer`, as `Customer` and `Admin` are both models that are available in the TicketShop application. Have look at the `Customer` and `Admin` models in order to see how Devise injects its own logic. Also, you may see the latest migrations created by Devise automatically in the `db/migrate` directory. In order to operate with CanCanCan, it is necessary to provide a `current_user` method that returns the model matching the current user, which is why such method is implemented in the `ApplicationController` class.
4. Go to `app/controllers/orders_controller.rb`. See that Cancancan implements the `load_and_authorize_resource` method that prevents a user from accessing orders placed by other users. However, this controller is incomplete, as it still requires that a user is authenticated before they can see their orders. You need to investigate how Devise can provide this functionality through a filter, so that before controller actions are executed, the user is signed in. The solution to this is a one liner.
5. Inspect the file `app/models/ability.rb`. This is CanCanCan's central configuration file in the TicketShop, which defines how resources are accessed by different kinds of users. You are required to complete the `initialize` method in the `Ability` class, so that access to resources is properly controlled per each kind of user.
6. Inspect `app/controllers/shopping_cart_controller.rb` and see how the shopping cart cookie is saved depending on who the logged-in user is. To allow many users to share the same web browser and each have their own shopping cart, the trick is to prepend the user's email address to the name of the cookie.  
7. Run the `rake routes` task and see the many routes that are enabled by Devise for `User` and `Admin` resources. You may also want to check out the `config/routes.rb` file in order to see how Devise has been configured for both models.
8. The sign-in page for administrators is accessible through the `admins/sign_in` path. You may sign in with the admin user `admin@ticketshop.com`, by entering the password you set running the `rake admin:create_admin_user` task.
9. The sign-in route for customers is `customers/sign_in`. Use the rails console to see what (fake) users are available. You may use any of them to sign in as a customer, with password `123123123`.
9. Finally, you may want to check out the task at `lib/tasks/create_admin_user.rake`. It is a good practice to create a rake task that allows creating the admin user, instead of simply creating the user in the seeds file and carelessly exposing the default password in your sources' repository.

## Graded Steps

1. [1.5 points] Complete the layout of the application, so that behavior of sign-in, sign-out, sign-up links works properly. Also, the shopping cart must only be visible to signed-in customers. Non-registered users must only be able to see events.
2. [2.0 points] Complete the Event view files described above, so that access control is possible. Only the admin user should be able to create/edit `Event` and `TicketType` resources. On the other hand, only customers should be able to purchase tickets. Also, non-registered users must see a link to the customer sign-in page when the list of available ticket types appears in the table listing them.
3. [.5 points] Enable Devise's filter at `app/controllers/orders_controller.rb` requiring the customer to log in before accessing any actions provided by that controller.
4. [2.0 points] Complete `app/models/ability.rb` so that CanCanCan properly enforces access control to resources.

With the above steps, your TicketShop will permit the user searching for events, and deleting orders. 

## Grading

Each of the four parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

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

* [Cancancan](https://github.com/CanCanCommunity/cancancan)
* [Devise](https://github.com/heartcombo/devise)
* [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
* [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
* [Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)
* [The HTML DOM API](https://developer.mozilla.org/en-US/docs/Web/API/HTML_DOM_API)
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
