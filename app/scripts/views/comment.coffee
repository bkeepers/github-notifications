class notifications.Views.Comment extends Backbone.View
  template: JST['app/scripts/templates/comment.ejs']

  render: ->
    @$el.html @template(@model.toJSON())
    @
