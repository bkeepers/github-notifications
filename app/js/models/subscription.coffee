# See http://developer.github.com/v3/activity/notifications/#get-a-thread-subscription
class app.Models.Subscription extends Backbone.Model
  defaults:
    ignored: false

  initialize: ->
    @url = @get('url')

  mute: ->
    @save 'ignored', true, {attrs: {'ignored': true}}

  unmute: ->
    @save 'ignored', false, {attrs: {'ignored': false}}

  toggle: ->
    if @get('ignored') then @unmute() else @mute()
