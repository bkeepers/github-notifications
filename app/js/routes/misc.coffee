class App.Routers.Misc extends Backbone.Router
  routes:
    'feedback': 'feedback'

  feedback: ->
    new App.Views.Feedback().render()
