# Solution to Lab Assignment #6

## Introduction

This sixth lab assignment will be graded and you will be working in pairs, so you can team up with a peer to start working on it. You will continue working on the ticket sales application, now adding controller logic and a RESTful API to manage resources in the application from external parties.

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

Note that the last command will launch an application server that will allow accessing your application from either a web browser (at [http://localhost:3000](http://localhost:3000)), another kind of user agent, or even another application able to consume the RESTful API that your application will implement. 

## Web APIs

A RESTful API is a web API that defines a set of operations through which it is possible for third parties (other web applications, or client software) to act and work on _resources_ that are managed by your application. RESTful APIs are consumable through the HTTP protocol, and define their operations in a highly structured and predictable manner. Given that a RESTful API is based on the HTTP protocol, clients will issue HTTP requests to your web application to invoke operations. In the application side, this involves configuring routes for resources that are ought to be available from your application to API clients.

Read section 2.2 of [this guide](https://edgeguides.rubyonrails.org/routing.html#crud-verbs-and-actions]) in order to understand how a RESTful API can be defined for a resource, based on a set of routes that Ruby on Rails can automatically generate.

## Routes and Routing Scopes

You may recall from lectures that there is a component in RoR, and in many other current web application frameworks, which takes charge of routing client requests to controllers, i.e., the ['Rails Router'](https://edgeguides.rubyonrails.org/routing.html#the-purpose-of-the-rails-router) (henceforth just 'the router'). In RoR applications, the router has a configuration file located at `config/routes.rb`. In this file, you may configure the routes available, which basically consists on specifying directives that map requests by their HTTP methods and URL patterns to controllers and their actions. With Ruby on Rails, routes can be RESTful, or completely arbitrary.

In addition, is possible to define different routing _scopes_ (you may think of these as route namespaces) in a RoR application, in such a way that you can have differents sets of routes for requests that are intended for a web API versus routes that are meant for a web application. The documentation from Rails Guides gives some clear examples about defining routing scopes. In this very assignment, you will be guided towards creating a routing scope for a web API that permits acting on User, Review and Beer restful resources.

## Controller Flavors

Controllers in RoR are classes which generally inherit from one of two different parents; `ActionController::Base` or `ActionController::API`. The former is intended to be used for implementing the functionalities of a traditional web application controller, including generating (rendering) views based on HTML, session management, cookies, etc. The latter can be considered to be a lightweight version that is used for implementing web APIs, which do not require such features. In this lab assignment, we will focus on implementing API controllers. 

## Who the heck is JSON, anyway?

Nowadays, use of [JavaScript Object Notation (JSON)](https://en.wikipedia.org/wiki/JSON) has become a _de facto_ standard by which objects and data are serialized in the web. RESTful APIs commonly use JSON as a means for serializing input data for their operations, as well as the objects that these return.

Here you may see [a few examples about JSON](https://www.w3schools.com/js/js_json_syntax.asp) and its syntax rules. It is a lightweight notation, compared to similar technologies in other standards that are used to implement web APIs, such as XML web services.

In this lab assignment, you will use JSON to specify parameter objects for a RESTful API, and you will have the API generate a JSON response for the client.

## Consuming a Web API

To consume a Web API, the client application needs to talk HTTP, and be able to serialize outgoing objects and data with JSON, as well as parsing incoming objects from the API based on this format. There are different ways in which you can test an API without need to create an actual client application:

* Use a command line tool such as cURL. Recall that you used cURL in lab assignment 1. [See here some examples](https://www.baeldung.com/curl-rest).
* Use a GUI tool such as [Postman](https://www.postman.com). Postman is perhaps the easiest and most convenient tool with which you can easily configure and run calls to a web API. Postman is _not_ included with the course's virtual machine but it can be easily installed manually. You may install it in your host operating system as well if you like.

## Now let's get hands on

This part of the assignment is non-graded and it is intended for you to see how a RESTful API is implemented with Rails.

* Go to `app/controllers/api_controller.rb`. You will see that the `APIController` class inherits from `ActionController::API`. Controllers for RESTful APIs will be based on this class. You will find `ApplicationController` at `app/controllers/application_controller.rb`.
* Now, open `config/initializers/inflections.rb`. The Inflector transforms words from singular to plural, class names to table names, etc. By default, the inflector will not allow acronyms to work well. For instance the controller class name `APIController` does not work as the inflector expects PascalCase to be used for naming models and controller classes. This is why you will see the following line in the `inflections.rb` file:
```ruby
inflect.acronym 'API'
```
If we omit this line, code will break, as `APIController` and its derived classes will not work properly.
* Take a careful look at the `config/routes.rb` file. You will see that the root of the application points to `pages#home`. There is a `PagesController` located at `app/controllers/pages_controller.rb`. It just contains an empty `home` action.  The corresponding view, which is automatically rendered, is placed at `app/views/pages/home.html.erb`. Try opening the [root path on your browser](http://localhost:3000) to test this route.
* In the `routes.rb` file, you will then see that a special route scope has been defined in order to implement a RESTful API. There is an API scope (`api`), and within it, a scope for version 1 (`v1`) of the API. In addition, there is a declaration specifying that the default response format of the API controllers is in JavaScript Object Notation (JSON) format.
* Now, open `app/controllers/api/v1` and have a look at `ticket_types_controller.rb` See how the `TicketTypesController` class is defined. Note that the names of the route scopes described above appear as nested namespaces wherein the controller class is defined, i.e., `API::V1::TicketTypesController`.
* When creating an API, it is a good idea to pick the good practices shown above. That is, create an api route scope in `config/routes.rb`, and within the scope, define nested scopes for subsequent versions of the API that may be developed in future releases of your application. 
* Controllers for your API need to be created under the `app/controllers/api/v1` folder, such as the `TicketTypesController` defined in `ticket_types_controller.rb`.
* Other regular application controllers will remain available under `app/controllers`.
* Go back to the `config/routes.rb` file. You will see that below the nested resourceful route definitions for the API, there is a resourceful route definition in the global scope for `ticket_type`.
* Now, go to `app/views/api/v1/ticket_types` and see the files in the folder. These files are Jbuilder templates which are used to generate JSON responses by the `API::V1::TicketTypesController`.
You will see about templates and rendering in a few more classes. Just look at these templates so that you understand how JSON-based resource representations are generated by the API.
* Then, open your web browser and call the `index` action of the non-api `TicketTypesController`, by opening [http://localhost:3000/ticket_types](http://localhost:3000/ticket_types) -- You will see an HTML representation of the list of ticket types available, rendered by the `index` action of `TicketTypesController`.
* Now, open in the same browser window the `index` action of the api-based `TicketTypesController`, by opening [http://localhost:3000/api/v1/ticket_types](http://localhost:3000/api/v1/ticket_types) -- 
You will now see a JSON-based representation of the list of ticket types available, rendered by `API::V1::TicketTypesController`.
* `TicketType` is specified as a plural resource in `config/routes.rb`, therefore, the RESTful routes [described here](https://guides.rubyonrails.org/routing.html#resource-routing-the-rails-default) will be automatically accessible by a client. 
* The regular controller is intended to be accessible by a user from the web browser, whereas the API controller is intended to be accessible as a web service from another web application, a mobile application or a rich-client application (Android, iOS, .NET, Java, etc.). The beauty of web technologies is that standard protocols and representations will allow interoperability among different platforms and operating systems, with no additional development effort. 

## You can make it

* Now, add your own `EventsController` to the API. You may add a scaffold controller to your 
project by running:
```
rails g scaffold_controller event
``` 
This will create the controller, along with views, tests, helpers, etc.
* Copy the controller just generated from `app/controllers/events_controller.rb` to `app/controllers/api/v1/events_controller.rb`.
* Modify the controller in `app/controllers/api/v1/events_controller.rb` so that the `API::V1` scopes are prepended to the class name (make sure that `API::V1` is all in uppercase!).
* Redefine route scopes, following the current examples in `config/routes.rb` so that `TicketType` is now a plural nested resource of events. This will automatically generate routes for `TicketType` resources nested into `Event` resources. For example, the `api/v1/events/1/ticket_types` path will trigger the `API::V1::TicketTypesController#index` action, which will allow displaying all ticket types that relate to the event with id 1.
* Now, edit `API::V1::EventsController` and `API::V1::TicketTypesController` to implement the following:
1. [1 point] A RESTful API route/action that permits obtaining all events available.
2. [1 point] A RESTful API route/action that permits adding a new event.
3. [1 point] A RESTful API route/action that permits obtaining a specific event (by id).
4. [1 point] A RESTful API route/action that permits adding a ticket type to an event (by id).
5. [1 point] A RESTful API route/action that permits obtaining all ticket types related to an event (by id).
6. [1 point] Modify the action in (3), so that in the response it renders the event resource containing the ticket type resources that are related. The JSON objects that are generated for the response are based on Jbuilder templates that are available at `app/views/api/v1/events`. Note that the `_event.json.builder` template defines how an event object is serialized in JSON format. It is used to render responses in both in `show` and `index` actions of `API::V1::TicketTypesController`. You will find the [official Jbuilder tutorial here](https://github.com/rails/jbuilder).
* Use [Postman](https://www.postman.com/downloads/) to debug and try out your API. If you need to install it in Debian, [try this guide](https://www.how2shout.com/linux/2-ways-to-install-postman-on-debian-11-bullseye-or-10-buster/). Create and share a Postman collection containing all requests needed to try out the above 1-6 requirements. Place the link to your collection in this file, in the section below. 
* Make sure you add, commit and push your changes.

## Your Report

* Please provide the link to the postman collection containing test requests for your application here: 
https://www.getpostman.com/collections/3bfc24257fcfd983df26
* Describe any other relevant details about your API implementation here: 

## Grading

Each of the three parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

Please commit and push your code to GitHub until tomorrow (Wednesday 6th) at 23:59.

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
