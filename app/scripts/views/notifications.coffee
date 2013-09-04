class app.Views.Notifications extends Backbone.View
  el: '#notifications'
  template: JST['app/scripts/templates/notifications.ejs']

  initialize: =>
    @collection.fetch()
    @render()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  render: ->
    @$el.html @template()
    @addAll()
    app.trigger 'render', @
    @

  add: (notification) ->
    view = new app.Views.Notification(model: notification)
    @$('ul').append(view.render().el)

  addAll: ->
    @collection.each(@add, @)
