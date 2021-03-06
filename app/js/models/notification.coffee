# See http://developer.github.com/v3/activity/notifications/
class App.Models.Notification extends Backbone.Model
  initialize: ->
    @url = @get('url')
    @subject = new App.Models.Subject.for(@)
    @subscription = new App.Models.Subscription(id: @id, url: @url + '/subscription')
    @on 'selected', @read

  toJSON: ->
    _.extend super, subject: @subject.toJSON()

  # Mark the notification as read.
  read: ->
    # Don't mark unsupported notifications as read
    return unless @subject.get('url')
    return if app.isDevelopment()

    if @get('unread')
      # FIXME: don't reference global `app.repositories`
      repository = app.repositories.get(@get("repository").id)
      repository?.decrement()

    @save {unread: false}, {patch: true}
