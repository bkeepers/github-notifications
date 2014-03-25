class App.Routers.Horrible extends Backbone.Router
  routes:
    'feedback': 'feedback'

  feedback: ->
    new App.Views.Feedback().render()
