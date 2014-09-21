# GitHub Notifications ![Build Status](https://travis-ci.org/bkeepers/github-notifications.png)

a rich interface for [GitHub Notifications](https://github.com/notifications). Check it out here: https://notifications.githubapp.com/

## Local Development

To run the app locally, make sure you have a working Node.js environment, and then from the terminal run:

    $ script/bootstrap
    $ script/server

This will install all the needed dependencies, start up a server, and open
[localhost:8000](http://localhost:8000) in your browser.

## Contributing

This project is built using [lineman](http://www.linemanjs.com/), a simple tool for
building JavaScript web applications. There is no server component. The [app](app)
gets compiled into static HTML, CSS, and JavaScript that uses the GitHub API.

The app is mostly CoffeeScript and uses [Backbone](http://backbonejs.org).
[app/js/app.coffee](app/js/app.coffee) is the starting point.

The styles use [Stylus](http://learnboost.github.io/stylus/). [app/css/app.styl](app/css/app.styl) is
the starting point.

If you find what looks like a bug:

1. Check out the [issues on GitHub](http://github.com/bkeepers/github-notifications/issues/) to see if anyone else has reported the same issue.
3. If you don't see anything, create an issue with information on how to reproduce it.

If you want to contribute an enhancement or a fix:

1. Fork the project on GitHub.
2. Make your changes.
3. Commit the changes without making changes to any other files that aren't related to your enhancement or fix.
4. Send a pull request.
