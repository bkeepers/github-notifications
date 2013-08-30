class app.Models.Subject extends Backbone.Model
  @for: (subject) ->
    model = app.Models[subject.type] || app.Models.Subject
    new model(subject)

  initialize: ->
    @url = @get('url')

  toJSON: ->
    _.extend super, octicon: @octicon
