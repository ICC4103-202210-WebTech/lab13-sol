# Lab Assignment #7
**Names:**

## Introduction

In this lab assignment you will create a home page for the Ticket Shop, and provide navigation from the home page to different sections of the site. For this, you will need to complete the routes of the application, and define a layout for the site based on HTML and basic CSS. You are allowed to work individually or in pairs.

## First Steps (Don't rush, read this first!)

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

## Pre-requisites

There are a few concepts seen in class (see Slide Deck 7) that you must understand before starting work on this lab assignment:

1. You must be acquainted with [HTML 5 basics](https://www.w3schools.com/html/html_basic.asp), including [elements](https://www.w3schools.com/html/html_elements.asp), [attributes](https://www.w3schools.com/html/html_attributes.asp), [semantic elements](https://www.w3schools.com/html/html5_semantic_elements.asp), [headings](https://www.w3schools.com/html/html_headings.asp), [paragraphs](https://www.w3schools.com/html/html_paragraphs.asp), [links](https://www.w3schools.com/html/html_links.asp) (even though you will use Rails helpers to generate them in this assignment), [lists](https://www.w3schools.com/html/html_lists.asp), [tables](https://www.w3schools.com/html/html_tables.asp), and [comments](https://www.w3schools.com/html/html_comments.asp). 
2. Review slide deck 7, with regard to layouts, templates and partials. Read the [Layouts and Rendering](https://edgeguides.rubyonrails.org/layouts_and_rendering.html) guide to understand this. 
3. Read about [Embedded RuBy (ERB) here](learnhowtoprogram.com/ruby-and-rails/routing-with-ruby/embedded-ruby) -- just read the introduction and the section titled "Embedded Ruby (ERB) Tutorial". ERB is the template engine used in rails to create views.
4. Remember how [Path and URL](https://edgeguides.rubyonrails.org/routing.html#path-and-url-helpers) helpers become enabled in Rails when you set up routes for resources.

## Test your might

1. [1 point] Edit the `config/routes.rb` file and define resourceful routes for `event`, `ticket_type`, `ticket`, `order`, and `customer` resources. Make sure you adequately nest resources in your routes, that is, nest tickets within orders, and orders within customers. Use the shallow routing option for tickets and orders. You do not need to nest ticket types to events. It is OK if you want to do it, but you will not use it later on. Make sure that your application only supports show and index routes. You will not use all others in this assignment, i.e., new, edit, destroy, etc.

2. [0.5 point] Using the appropriate rails generator (`scaffold_controller`), add controllers for all of the above-listed resources that do not have a controller in the starter code. Recall that `scaffold_controller` will create default views for RESTful actions automatically. You should delete all files under `app/views` that you will not use, including views for edit, and new actions. Also, you may safely delete `_form.html.erb` partial views that are generated.

3. Make sure your `config/initializers/inflections.rb` file contains the following code, as you will need it to allow creating a `ShoppingCart` controller (with singular name). If you do not include the code, the controller generator will create a controller with a pluralized name.

   ```ruby
   ActiveSupport::Inflector.inflections(:en) do |inflect|
     inflect.uncountable "shopping_cart"
     inflect.uncountable "ShoppingCart"
   end
   ```

4. [1.5 points] Add a controller for a singular resource called `ShoppingCart` (`ShoppingCartController`). Within this controller, only enable the `show` action and the corresponding route in the `config/routes.rb` file -- note that `ShoppingCart`  is a _singular_ resource, not a plural one! The view for the shopping cart will be `show.html.erb`. The `show` view should just contain an HTML heading 2 title with the text `Shopping Cart`. Below, an HTML table must appear with a selection of five random tickets loaded from the database. The table containing the tickets must contain: (1) row number (1-5), (2) the name of the corresponding event, (3) the date and time of the corresponding event, (4) the name of the ticket type, (5) and the ticket price. Hint: First make sure that in `ShoppingCartController::show` contains the necessary query for five random tickets, and assign the result of the query to an atribute variable, e.g., `@tickets`. Then use this attribute in the respective view (`shopping_cart/show.html.erb`) in order to generate the table (use an `each_with_index` ruby loop to generate the table rows, google it if you have not seen how it works!). Here is an example embedded ruby code that will likely be inspiring to you:

   ```ruby
   <ul>
   <%= [1,2,3].each do |v| %>
   	<li><%= v %></li>
   <% end %>
   </ul>
   <!-- The above embedded ruby code will render as follows: -->
   <ul>
     <li>1</li>
     <li>2</li>  
     <li>3</li>
   </ul>
   ```

5. [2 points] Edit the application layout, located at `app/views/application.html.erb`. You need to add the following HTML 5 structural elements to your layout:

   * A `<header>` element intended for the top of the layout, contaning the name of your Ticket Shop in heading 1 size text. The text must be linked to the root path of the application, that is, whenever the user clicks on the name of the Ticket Shop, the browser will navigate to the root path. **In this assignment, always use a rails helper to generate links, do not do this by hand**. You may freely name your ticket shop as you wish. 

   * A navigation bar below the header (use the `<nav>` element). Within the `<nav>` element define an unordered list (`<ul>` element), with `navbar` `id` containing list items (`<li>` elements) comprising links to `Events`, `Profile` (this should link to `customer#show` with `id` 1), `Shopping Cart` (`shopping_cart#show`), and `Orders` (`orders#index`). We insist, please use rails helpers to generate links to the different sections.

   * Then create a `div` element with `container` `id`. You will place within this div element the next two elements below (`<aside>` and `<main>`):

   * Create an aside section (use the `<aside>` element) in which a partial view is rendered. Give it  `customer_info` as the `id` attribute. The partial view should display the name of first customer in the database (`Customer.first`). As this partial is instanced by the application layout, it will always render, and will need the user object. Place the partial in `app/customers/_customer.html.erb`.  A good idea is to make the `customer` object always available from the `ApplicationController`class, by using a filter. Add the following filter code to this class:

     ```ruby
     before_action :set_customer
     
     private
     
     def set_customer:
       @customer = Customer.first
     end
     ```

   * Create a main content section in the layout with the `<main>` element. In this section, place the code to the rails `yield` method that will allow action templates rendering their response.

   * Finally, add a `<footer> ` element containing a heading 4 text `Contact Information`,  and a paragraph (`<p>` element)  below contaning any fake contact information for your Ticket Shop.

6. [1 point] Edit the home page at `views/pages/home.html.erb`. Have this home page show a table contaning the five events with the latest dates, loaded from the database. Make sure the table shows the event name and the event date. Hint: First have `PagesController::home` make the necessary query and assign the result to an atribute variable, e.g., `@upcoming_events`. Then use this attribute in order to generate the table.

7. By now, you should be able to run your application and navigate to the different sections from the home page, however, without an aesthetically pleasing layout. 

8. Add [this CSS template](https://gist.github.com/claudio-alvarez/b3b3c5d67e04ae8fabd138e6a1ad0560) to your application. Place it in the file `app/assets/stylesheets/main.css`. After this, run your application again and experience the difference. We have not covered CSS yet, but you may study the CSS file, along with the CSS tutorial at W3 Schools in order to understand the basics.

   * If the layout or styles look still broken or poor, it is likely that you did not assign the `id` attributes correctly to the elements in the layout. Go through the substeps in (5) in order to get this right.

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
