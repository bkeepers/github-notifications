# See http://developer.github.com/v3/activity/notifications/
class app.Models.Notification extends Backbone.Model
  initialize: ->
    @url = @get('url')
    @subject = new app.Models.Subject.for(@)
    @subscription = new app.Models.Subscription(id: @id, url: @url + '/subscription')
    @on 'selected', @read

  toJSON: ->
    _.extend super, subject: @subject.toJSON(), starred: @isStarred()

  # Mark the notification as read.
  read: ->
    # Don't mark unsupported notifications as read
    return unless @subject.get('url')
    @save {unread: false}, {patch: true} unless app.isDevelopment()
    repository = app.repositories.get(@get("repository").id)
    repository?.decrement()

  # Star the notification
  star: ->
    @collection.starred.create(@toJSON())
    @trigger 'change'

  # Unstar the notification
  unstar: ->
    @collection.starred.get(@id)?.destroy()
    @trigger 'change'

  # Star or unstar the notification
  toggleStar: ->
    if @isStarred() then @unstar() else @star()

  # Returns true if the notification is starred
  isStarred: ->
    @collection.starred.get(@id)?
