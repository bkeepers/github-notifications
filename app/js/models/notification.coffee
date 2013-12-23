class app.Models.Notification extends Backbone.Model
  initialize: ->
    @url = @get('url')
    @subject = new app.Models.Subject.for(@get('subject'))
    @subscription = new app.Models.Subscription(id: @id, url: @url + '/subscription')
    @on 'selected', @read

  toJSON: ->
    _.extend super, subject: @subject.toJSON(), starred: @isStarred()

  read: ->
    # Don't mark unsupported notifications as read
    return unless @subject.get('url')
    @save {unread: false}, {patch: true} unless app.isDevelopment()

  star: ->
    @collection.starred.create(@toJSON())
    @trigger 'change'

  unstar: ->
    @collection.starred.get(@id)?.destroy()
    @trigger 'change'

  toggleStar: ->
    console.log 'toggling', @isStarred(), @id
    if @isStarred() then @unstar() else @star()

  isStarred: ->
    @collection.starred.get(@id)?
