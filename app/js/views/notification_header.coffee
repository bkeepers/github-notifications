class app.Views.NotificationHeader extends Backbone.View
  template: JST['app/templates/notification_header.us']
  tagName: 'header'

  events:
    'click .star': -> @model.toggleStar()

  initialize: ->
    @subscription = new app.Views.Subscription(model: @model.subscription)
    @listenTo @model.subject, 'change', @render
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    @$('.subscription').replaceWith @subscription.render().el
    @
