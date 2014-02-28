class app.Models.Subject extends Backbone.Model
  @for: (notification) ->
    subject = notification.get('subject')
    subject.last_read_at = notification.get('last_read_at')
    model = app.Models[subject.type] || app.Models.Subject
    new model(subject)

  initialize: ->
    @url = @get('url')
    @timeline = new app.Collections.Timeline([], subject: @)

    @comments = new app.Collections.Comments([], last_read_at: @get('last_read_at'))
    @events = new app.Collections.Events([], subject: @)

    @on 'change', ->
      @timeline.add @ if @get('body_html')

      @comments.url = @get('comments_url')
      @timeline.observe @comments

      @events.url = @get('events_url')
      @timeline.observe @events

  isUnread: ->
    !@get('last_read_at') ||
      moment(@get('last_read_at')) < moment(@get('created_at'))

  toJSON: ->
    _.extend super, octicon: @octicon, display_type: @display_type
