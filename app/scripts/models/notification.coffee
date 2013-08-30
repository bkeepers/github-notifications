class notifications.Models.Notification extends Backbone.Model
  initialize: ->
    @subject = new notifications.Models.Subject.for(@get('subject'))

  toJSON: ->
    _.extend super, subject: @subject.toJSON()
