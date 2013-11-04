# GitHub Notifications

This is an experiment with creating a more rich interface for consuming [GitHub Notifications](https://github.com/notifications).

## Local Development

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

## Contributing

If you find what looks like a bug:

1. Check out the [issues on GitHub](http://github.com/bkeepers/github-notifications/issues/) to see if anyone else has reported the same issue.
3. If you don't see anything, create an issue with information on how to reproduce it.

If you want to contribute an enhancement or a fix:

1. Fork the project on GitHub.
2. Make your changes.
3. Commit the changes without making changes to any other files that aren't related to your enhancement or fix.
4. Send a pull request.
