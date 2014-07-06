class App.Models.Repository extends Backbone.Model

  notifications: ->
    new App.Collections.Notifications([], url: @notifications_url())

  notifications_url: ->
    @get('notifications_url').replace(/\{.*\}/, '')

  unread_count: ->
    count = @get('unread_count')
    count = '∞' if count > 999
    count

  toJSON: ->
    _.extend super, unread_count: @unread_count()

  decrement: ->
    return if @get('unread_count') == 0
    @set('unread_count', @get('unread_count') - 1)

  read: ->
    @set('unread_count', 0)
