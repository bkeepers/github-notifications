class notifications.Views.NotificationsView extends Backbone.View
  el: '#notifications'
  template: JST['app/scripts/templates/notifications.ejs']

  initialize: =>
    @collection.fetch()
    @render()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  render: ->
    @$el.html(@template())
    @

  add: (notification) ->
    view = new notifications.Views.NotificationView(model: notification)
    @$('ul').append(view.render().el)

  addAll: ->
    @collection.each(@add, @)
