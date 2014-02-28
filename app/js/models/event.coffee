class app.Models.Event extends Backbone.Model
  initialize: ->
    super
    @url = @get('url')

  # TODO: implement this
  isUnread: ->
    false
