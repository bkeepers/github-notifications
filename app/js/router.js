window.app.router = Backbone.Router.extend({
  routes: {
    "login" : "login",
    "home"  : "home",
    "*path" : "login"
  },

  login: function() {
    this.renderPage(window.app.views.LoginPage, {
      AuthenticationService: window.app.services.AuthenticationService
    });
  },

  home:  function() {
    this.renderPage(window.app.views.HomePage, {
      AuthenticationService: window.app.services.AuthenticationService
    });
  },

  renderPage: function(PageClass, options) {
    var page = new PageClass(options);
    $("#view").empty().append(page.render().el);
  }
});

$(function() {
  window.router = new window.app.router();
  Backbone.history.start();
});
