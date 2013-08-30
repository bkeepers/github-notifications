class notifications.Models.NotificationModel extends Backbone.Model
  initialize: ->
    @subject = new notifications.Models.SubjectModel.for(@get('subject'))

  toJSON: ->
    _.extend super, subject: @subject.toJSON()
