class app.Models.Subject extends Backbone.Model
  @for: (subject) ->
    new app.Models[subject.type](subject)

  initialize: ->
    @url = @get('url')

  toJSON: ->
    _.extend super, octicon: @octicon
