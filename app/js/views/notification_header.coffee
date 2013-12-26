# Header view for a notification
class app.Views.NotificationHeader extends Backbone.View
  template: JST['app/templates/notification_header.us']
  tagName: 'header'

  events:
    'click .star': -> @model.toggleStar()

  # Required options:
  # model - a notification object
  initialize: ->
    @subscription = new app.Views.Subscription(model: @model.subscription)
    @listenTo @model.subject, 'change', @render
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    @$('.subscription').replaceWith @subscription.render().el
    @
