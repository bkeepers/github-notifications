# A Lineman JS Template using Backbone

This is a project template for Backbone JS applications using [Lineman](http://www.linemanjs.com).

It includes the following features:

1. Template Precompilation into the `JST` namespace using `grunt-contrib-jst`
2. A basic login, logout service bound to sample routes inside `config/server.js`
3. A router, and 2 views `home_page` and `login_page`, and 1 model `home_page`
4. A model `change` event binding that shows a message on mouseover
5. A simple scheme for rendering views into a single dom element, `#view`
6. A working, bound login form (username/password don't matter, but are required)
7. Auto generated [sourcemaps](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) with inlined sources via [grunt-concat-sourcemap](https://github.com/kozy4324/grunt-concat-sourcemap) (you'll need to [enable sourcemaps](http://cl.ly/image/1d0X2z2u1E3b) in Firefox/Chrome to see this)

# Instructions

1. `git clone https://github.com/davemo/lineman-backbone-template.git my-lineman-app`
2. `cd my-lineman-app`
3. `npm install`
4. `lineman run`
5. open your web browser to localhost:8000

# Running Tests

1. `lineman run` from 1 terminal window
2. `lineman spec` from another terminal window

Hopefully this helps you get up and running with BackboneJS!
