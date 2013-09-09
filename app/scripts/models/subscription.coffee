class app.Models.Subscription extends Backbone.Model
  defaults:
    ignored: false

  initialize: ->
    @url = @get('url')

  mute: ->
    @save ignored: true

  unmute: ->
    @save ignored: false

  toggle: ->
    if @get('ignored') then @unmute() else @mute()
