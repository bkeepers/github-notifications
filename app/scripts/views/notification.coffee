class notifications.Views.NotificationView extends Backbone.View
  tagName: 'li'
  template: JST['app/scripts/templates/notification.ejs']

  render: ->
    @$el.html @template(@model.toJSON())
    @
