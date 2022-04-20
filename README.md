# Starter code for Lab Assignment #8

## Introduction

In this lab assignment you will apply styling based on the Bootstrap CSS library to the Ticket Shop, and add web forms to create and update one of its models. You may continue to work in pairs.

#### Pre-requisites

1. You must be acquainted with [Bootstrap 5.1](https://getbootstrap.com/docs/5.1/getting-started/introduction/), including
layouts (i.e., [container variants](https://getbootstrap.com/docs/5.1/layout/containers/)), the [grid system](https://getbootstrap.com/docs/5.1/layout/grid/), [formatting content](https://getbootstrap.com/docs/5.1/content/reboot/), [basic components](https://getbootstrap.com/docs/5.1/components/accordion/), and [forms](https://getbootstrap.com/docs/5.1/forms/overview/). 
2. Study web forms in Rails as introduced in slide deck 7.

## About Bootstrap

Bootstrap is a user interface library for web applications, based on CSS and JavaScript. It facilitates creating view layouts and templates, and applying a consistent set of styles to objects in an HTML document.

Use of Bootstrap in a Rails application will generally entail adding the library as a dependency (i.e., from a gem, manually, or by using a Javascript utility), customizing the application layout(s), and applying bootstrap styles to view templates and partials. This same process applies if using any other user interface library, such as [Tailwind CSS](https://tailwindcss.com/) and [Bulma](https://bulma.io/).

After adding Bootstrap to your Rails application, the first step is to edit the application layout to add a [_container_](https://getbootstrap.com/docs/5.1/layout/containers/). Containers are the most basic layout element in Bootstrap and are required when using the default grid system. Containers are used to contain, pad, and (sometimes) center the content within them. While containers can be nested, most layouts do not require a nested container. Within a container, commonly rows will be used to divide spaces vertically, and columns will be inserted within the rows to use space horizontally. A container can introduce "breakpoints", which allow reacommodating content whenever the vieport size changes. This is the way in which a responsive layout; that is, one that responds to viewport dimensions adaptively, and therefore can support different screen sizes and device form factors.

Common in Bootstrap layouts is the use of [navigation bars](https://getbootstrap.com/docs/5.1/components/navbar/). You may add a navigation bar at the top of the layout, to contain common functions, such as site search, and links to sign in, sign up, and sign out operations.

After adding a container to a layout, Rail's view templates can be customized to include Bootstrap styles. For instance, hyperlinks and buttons can be styled according to [button styles](https://getbootstrap.com/docs/5.1/components/buttons/). Also, Bootstrap styles can (and should) be [applied to forms](https://getbootstrap.com/docs/5.1/forms/overview/).

## How to add Bootstrap to a Rails Project

Bootstrap requires a Javascript library called [jQuery](https://jquery.com/), and another Javascript module called [popperjs](https://popper.js.org/) that provides tooltip and popover features. There are several ways in which Javascript libraries are installed in Rails applications as of version 7. In the starter code of this lab assignment, we are using Rails' 7 standard way of including Javascript dependencies, which is based on [import maps](https://www.digitalocean.com/community/tutorials/how-to-dynamically-import-javascript-with-import-maps), a feature where we can load Javascript modules dynamically at runtime. Import maps is a feature supported natively by Chrome and Firefox, and can run in other browsers by means of adapter code (a so-called [shim](https://en.wikipedia.org/wiki/Shim_(computing)#:~:text=In%20computer%20programming%2C%20a%20shim,API%20in%20an%20older%20environment.)).

The starter code of this assignment includes Bootstrap, and we have done so by following the instructions in [this tutorial](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/).

## Fancy paging of tables

If you have a look at the `/orders` path of the application, you will see that Bootstrap styles have been added to the tabular display of orders. Also, notice that a gem called [Pagy](https://github.com/ddnexus/pagy) has been added to support paginating model views. You may want to see the Gemfile to check out how it was included. Also, if you have a look at `OrdersController#index`, you will see how pagy is being called to prepare the paginated display of orders. Installation of pagy is quite straightforward according to the [documentation](https://ddnexus.github.io/pagy/how-to#gsc.tab=0). Furthermore, pagy has been configured to utilize bootstrap styles in this project. You may want to see this [guide](https://ddnexus.github.io/pagy/extras/bootstrap#gsc.tab=0) for details.

## Run the First Steps as Usual

The starter code contains a Rails project that implements all of the requirements of the previous lab assignment. You may open the project with VSCode, with RubyMine, or even use a text-based editor like Vim. If you use RVM, it should automatically switch to the proper version of ruby with the 'webtech' gemset (see the files `.ruby-version` and `.ruby-gemset` in the root path of your repository). Should you need to set this manually, run the following command:

```sh
rvm use 3@webtech # this will work on the course's VM
````

As in past assignments, if you take a look at the `db` directory, you will find there are two files:

* `schema.rb`: This file is automatically created by Rails when migrations are run. The file contains all DDL operations needed to initialize the database schema according to migrations.
* `seeds.rb`: It contains Ruby code that performs initialization in the database. You will see that a series of beers are created in the database.

In addition to the above, in this assignment the database will be automatically populated with fake models for you to write Active Record queries against. For this to work, follow these steps:

```sh
bundle install # new gems have been added to the Gemfile
rails db:setup
rails db:populate_fake_data # This will generate fake events, customers, etc.
rails s # Run the application with an application server
```

Note that the last command will launch an application server that will allow accessing your application from either a web browser (at [http://localhost:3000](http://localhost:3000)).

## An ungraded walk in the park

1. See the application layout located at `app/views/layouts/application.html.erb`. Study how the navigation bar is
created in the layout and how the space is distributed among the left aside and the main section of the page, by 
specifying Bootstrap columns.
1. Go to the Events section of the Ticket Shop, by clicking on the link at the top navigation bar. Study the file 
`app/views/events/index.html.erb` in order to see how styles are being applied to different elements displayed on the
this view. Particularly, have a look at the "event tile" that is rendered per each event.
2. Click on the "Add Event" button located on the events' index page. This will allow you to see the form available at
`app/views/events/new.html.erb`.
3. Now go to the Shopping Cart section of the site and take a look at how the Bootstrap table style is applied.
4. Lastly, go to the Orders section of the site and have a look at how paging controls have been added beneath the table
displaying the list of orders. A gem called [https://github.com/ddnexus/pagy](pagy) has been added to the project, which
enables paging features when displaying long tables. You may want to use this in your project assignments later on.

## Get psyched up!

1. [1 point] Edit the home page of the Ticket Shop to present the upcoming events in a format similar to the index view
of events you inspected according to the indications above. Move the view code at `app/views/events/index.html.erb:13-29` to a new partial view (e.g. `app/views/events/_event_tile.html.erb`), so that you can reuse the event tiles in the home page located at `app/views/pages/home.html.erb`.
1. [1 point] Modify `EventsController` so that the parameters required to create or update an event are permitted. That is, complete the call to the `fetch` method in `EventsController#event_params`. 
2. [0.5 point] Ensure that the form to create new events (i.e., '`/events/new`') works properly and it is possible to save a new event, however, keeping the event venue constant. You may add a constant routing parameter, or a hidden input field to the form at `app/views/events/new.html.erb`.
3. [1 point] Add a select box allowing to choose the event venue for a new event in the form at `app/views/events/new.html.erb`. The select box must display the names of available event venues, in alphabetical order. 
4. [1 point] Add a nested form to `app/views/events/new.html.erb` that allows creating a new event including just one ticket type. Make sure you properly set the `accepts_nested_attributes_for` macro in the `Event` model. 
5. [0.5 point] Complete the view at `app/views/events/show.html.erb`, showing the information about an event, including the name of the event venue, and a table displaying the available ticket types. Add links (with Bootstrap `btn`,`btn-primary` style) necessary to add a new ticket type to the current event (use the necessary path helper for this), and to open the `edit` page for the current event.
6. [1 point] Complete the view at `app/views/events/edit.html.erb`, allowing to update an event. You do not need to include a nested form to edit the ticket types.

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
