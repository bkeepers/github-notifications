class App.Models.Repository extends Backbone.Model

  initialize: ->
    @notifications = new App.Collections.Notifications([], url: @notifications_url())

  notifications_url: ->
    url.replace(/\{.*\}/, '') if url = @get('notifications_url')

  unread_count: ->
    count = @get('unread_count')
    count = '∞' if count > 999
    count

  toJSON: ->
    _.extend super, unread_count: @unread_count()

  decrement: ->
    return if @get('unread_count') == 0
    @set('unread_count', @get('unread_count') - 1)
