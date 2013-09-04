# NeUI

A New UI for GitHub notifications

The goal is to re-implement the experimental UI that was created for
notifications back when Notifications:Next launched, and then iterate on it to
create a better UI for catching up on changes to the projects you are watching.

Here is a screenshot of what the UI looked like before it was removed from
GitHub.com. The current status is nowhere near this.

![](http://cl.ly/1W3H1u3k2K1a0g2a102V/content)

## Getting Started

To run the app locally, make sure you have a working Node.js and Ruby (for
Sass/Compass) environment, and then from the terminal run:

    $ script/bootstrap
    $ script/server

This will install all the needed dependencies, start up a server, and open
[localhost:9000](http://localhost:9000) in your browser.

This project is built using [Yeoman](http://yeoman.io/), a simple tool for
building static webapps in node.js. There is no server component. The [app](app)
gets compiled into static HTML, CSS, and JavaScript that uses the GitHub API.

The app is mostly CoffeeScript and uses [Backbone](http://backbonejs.org).
[app/scripts/main.coffee](app/scripts/main.coffee) is the starting point.

The styles use Sass and Compass. [app/styles/main.scss](app/styles/main.scss) is
the starting point.
