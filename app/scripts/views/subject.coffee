class notifications.Views.Subject extends Backbone.View
  render: ->
    @$el.html(@template(@model.toJSON()))
    @
