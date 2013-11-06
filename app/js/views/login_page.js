window.app.views.LoginPage = Backbone.View.extend({
  template: JST["app/templates/login.us"],

  initialize: function(options) {
    this.AuthenticationService = options.AuthenticationService;
    _.bindAll(this);
  },

  events: {
    "submit form" : "login"
  },

  login: function(e) {
    e.preventDefault();
    var form = $(e.currentTarget);
    var credentials = {
      username: form.find("input[name='username']").val(),
      password: form.find("input[name='password']").val()
    };
    this.AuthenticationService.login(credentials).success(this.onLoginSuccess);
  },

  onLoginSuccess: function(response) {
    Backbone.history.navigate('home', true);
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  }
});
