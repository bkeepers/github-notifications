# Base class for the subject of a notification.
class App.Models.Subject extends Backbone.Model
  @for: (notification) ->
    subject = notification.get('subject')
    model = App.Models.Subject[subject.type] || App.Models.Subject
    new model(subject, notification: notification)

  # Override in subclass to show an icon
  octicon: null

  initialize: (attributes, options = {}) ->
    @url = @get('url')
    @notification = options.notification

    @timeline = new App.Collections.Timeline([], subject: @)
    @comments = new App.Collections.Comments([], subject: @)
    @events = new App.Collections.Events([], subject: @)

    @once 'change', ->
      @isReady = true
      @timeline.add @ if @get('body_html')

      @comments.url = @get('comments_url')
      @timeline.observe @comments

      @events.url = @get('events_url')
      @timeline.observe @events

  isUnread: ->
    @isUnreadSince(@get('created_at'))

  isUnreadSince: (timestamp) ->
    !@get('last_read_at') || moment(@get('last_read_at')) < moment(timestamp)

  toJSON: ->
    _.extend super, octicon: @octicon, display_type: @display_type

  # Execute the callback function when the subject is loaded.
  ready: (fn) ->
    if @isReady
      fn.call(@)
    else
      @once 'change', fn
