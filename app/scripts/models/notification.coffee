class app.Models.Notification extends Backbone.Model
  initialize: ->
    @subject = new app.Models.Subject.for(@get('subject'))

  toJSON: ->
    _.extend super, subject: @subject.toJSON()
