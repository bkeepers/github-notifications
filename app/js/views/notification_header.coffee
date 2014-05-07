# Header view for a notification
class App.Views.NotificationHeader extends Backbone.View
  template: JST['app/templates/notification_header.us']
  tagName: 'header'

  # Required options:
  # model - a notification object
  initialize: ->
    @subscription = new App.Views.Subscription(model: @model.subscription)
    @listenTo @model.subject, 'change', @render
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    @$('.subscription').replaceWith @subscription.render().el
    @
