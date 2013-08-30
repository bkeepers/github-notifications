class notifications.Views.NotificationView extends Backbone.View
  tagName: 'li'
  template: JST['app/scripts/templates/notification.ejs']

  render: ->
    console.log 'rendering', @model.toJSON()
    @$el.html @template(@model.toJSON())
    @
