class notifications.Models.Subject extends Backbone.Model
  @for: (subject) ->
    new notifications.Models[subject.type](subject)

  initialize: ->
    @url = @get('url')

  toJSON: ->
    _.extend super, octicon: @octicon
