class app.Models.Notification extends Backbone.Model
  initialize: ->
    @url = @get('url')
    @subject = new app.Models.Subject.for(@get('subject'))

  toJSON: ->
    _.extend super, subject: @subject.toJSON()

  read: ->
    @sync 'patch', @, data: '' # prevent it from sending attributes
