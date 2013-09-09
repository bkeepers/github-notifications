class app.Views.NotificationHeader extends Backbone.View
  template: JST['app/scripts/templates/notification_header.ejs']

  initialize: ->
    @render()
    @listenTo @model.subject, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    new app.Views.Subscription(model: @model.subscription, el: @$('.subscription'))
    @
