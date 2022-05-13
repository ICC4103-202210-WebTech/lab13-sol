# Starter code for Lab Assignment #10

## Introduction

In this lab you will use the HTML DOM API and JavaScript to implement a few interactive user interface features for the Ticket Shop application. You will improve the event creation/edition form to support adding multiple ticket types on the fly. Also, you will add buttons to sort events that are displayed on event views, by name and start date. 

You may continue to work in pairs.

## Pre-requisites

To get started, you will need to be familiar with the following topics covered in slide decks 9 and 10:

1. The HTML DOM, and its APIs, such as events, and traversal (e.g. `querySelector`, `querySelectorAll`, etc.).
2. The basics of ECMAScript (ES6), including function expressions, IIFEs, the console.
3. Data attributes in HTML 5. For this, you can see the first few slides of class 10, wherein this is explained.

## Non-graded Steps

1. Inspect the partial views in `app/views/events`. The display of events has been reorganized into different partial views. The `_event_list` partial contains events being displayed. It is composed of the `_event_sort_controls` partial and the `_event_tile` partial. The former contains buttons that will permit the user ordering events by name, or by start date, in ascending order.
2. See the `app/javascript` directory. As the name implies, JavaScript files used with application views are kept in this directory. There are some standard files that are auto-generated by Rails, like `application.js`, and a folder called `controllers`, with scripts that can be used in views, based on a frontend framework called [Stimulus](https://dev.to/bhumi/stimulus-rails-7-tutorial-5a6a) that is part of Rails 7. In this In our lab we will *not* be using Stimulus. Rather, you will be writing JavaScript that will directly intervenes views using the DOM API. Therefore, there is a directory called `app/javascripts/custom`, which contains a single script called `events.js`, which will contain all the code you will need to develop in this lab.
3. To use custom JavaScript files, like `events.js`, you need to edit `config/inportmap.rb`, and add a `pin` or `pin_all_from` function call. This has already been configured for the `app/javascript/custom` directory. Also, in `app/javascript/application.js`, an import of the `app/javascript/custom/events.js` file has been added.
4. In the `app/javascript/custom/events.js` file, you'll find an Immediately-Invoked Function Expression (IIFE) that defines various functions, and adds a handler to the document's `turbo:load` event. The `turbo:load` event is fired in the web browser every time an application view is loaded. In that event handler, you can access the entire DOM of the currently loaded page, and search for elements using functions like `querySelector`, and add event handlers to them.
5. Go to `events#new`. You will see that in the form there is an "Add Ticket Type" button that, when pressed, dynamically creates a new form and adds it to the parent form.

## Let's roll

1. [1.0 points] Edit the partial `app/views/events/_event_tile.html.erb`, so that the first (i.e., topmost) `<div>` element contains two data attributes. The first data attribute must be called `data-event-name` and its value must be the event name. The second data attribute must be called `data-start-date`, and its value must be, of course, the event start date.
2. [2.0 points] Go to `app/javascript/custom/events.js` and complete the code according to the requirements of GOAL (1) in the code comments.  Note that the function `registerClickHandlerForSortButton` permits configuring the sort buttons passing a comparison function. Two comparison functions are available; `cmpFnStartDate` (compares start date) and `cmpFnEventName` (compares event name). Test your code by clicking on the buttons that allow ordering events in the application homepage and `events#index` views. Watch the browser console for any errors. Use the `console` object to print out your debug comments.
4. [3.0 points] Complete the code in `app/javascript/packs/events.js` according to GOAL (2) in the code comments. You should look for all buttons with class `remove-ticket-type-btn-otf` and add a click event handler to them. The event handler should look for the closest ancestor `div` element with class `remove-ticket-type-btn-otf` and [remove it from the DOM](https://developer.mozilla.org/en-US/docs/Web/API/Element/remove)

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
