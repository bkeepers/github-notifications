# A collection of notifications persisted in local storage
class app.Collections.Starred extends Backbone.Collection
  localStorage: new Backbone.LocalStorage("starred")
