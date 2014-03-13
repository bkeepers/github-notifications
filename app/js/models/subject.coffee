class app.Models.Subject extends Backbone.Model
  @for: (notification) ->
    subject = notification.get('subject')
    subject.last_read_at = notification.get('last_read_at')
    model = app.Models[subject.type] || app.Models.Subject
    new model(subject, notification: notification)

  initialize: (attributes, options = {}) ->
    @url = @get('url')
    @notification = options.notification
    @comments = new app.Collections.Comments([], last_read_at: @get('last_read_at'))
    @on 'change', ->
      @comments.add @ if @get('body_html')
      @comments.url = @get('comments_url')

  isUnread: ->
    !@get('last_read_at') ||
      moment(@get('last_read_at')) < moment(@get('created_at'))

  toJSON: ->
    _.extend super, octicon: @octicon
