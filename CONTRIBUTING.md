# Contributing

This project is built using [Yeoman](http://yeoman.io/), a simple tool for
building static webapps in node.js. There is no server component. The [app](app)
gets compiled into static HTML, CSS, and JavaScript that uses the GitHub API.

## Getting Started

To run the app locally, make sure you have a working Node.js and Ruby (for
Sass/Compass) environment, and then from the terminal run:

    $ script/bootstrap
    $ script/server

This will install all the needed dependencies, start up a server, and open
[localhost:9000](http://localhost:9000) in your browser.

## JavaScript

The app is mostly CoffeeScript and uses [Backbone](http://backbonejs.org).
[app/scripts/main.coffee](app/scripts/main.coffee) is the starting point.

## Styles

The styles use Sass and Compass. [app/styles/main.scss](app/styles/main.scss) is
the starting point.
