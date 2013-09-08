class app.Models.Notification extends Backbone.Model
  initialize: ->
    @url = @get('url')
    @subject = new app.Models.Subject.for(@get('subject'))
    @subscription = new app.Models.Subscription(id: @id, url: @url + '/subscription')

  toJSON: ->
    _.extend super, subject: @subject.toJSON()

  read: ->
    @save {unread: false}, {patch: true}

  select: ->
    @collection.select(@) if @collection
