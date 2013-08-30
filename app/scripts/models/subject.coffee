class notifications.Models.SubjectModel extends Backbone.Model
  @for: (subject) ->
    new notifications.Models["#{subject.type}Model"](subject)

  initialize: ->
    @url = @get('url')

  toJSON: ->
    _.extend super, octicon: @octicon
