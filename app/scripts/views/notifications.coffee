class app.Views.Notifications extends Backbone.View
  el: '#threads'
  template: JST['app/scripts/templates/notifications.ejs']

  initialize: =>
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @

  add: (notification) ->
    view = new app.Views.Notification(model: notification)
    @$('ul').append(view.render().el)

  addAll: ->
    @$('ul').empty()
    @collection.each(@add, @)
