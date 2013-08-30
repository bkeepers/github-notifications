class notifications.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/scripts/templates/notification_details.ejs']

  initialize: ->
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    @
