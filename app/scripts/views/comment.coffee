class app.Views.Comment extends Backbone.View
  template: JST['app/scripts/templates/comment.ejs']
  className: 'discussion-comment'

  render: ->
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @
