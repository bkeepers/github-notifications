# Random tips
class App.Views.Tips extends Backbone.View
  el: '#tips'
  template: JST['app/templates/tips.us']

  tips: [
    "Hit the <kbd>?</kbd> key for all keyboard awesomeness."
    "You can reply to comments below the notifications."
  ]

  # Initialize the view
  initialize: ->
    @render()

  render: ->
    @$el.html @template(tip: @random())
    app.trigger 'render', @
    @

  random: ->
    @tips[Math.floor(Math.random() * @tips.length)]
