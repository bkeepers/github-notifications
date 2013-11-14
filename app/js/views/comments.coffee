class app.Views.Comments extends Backbone.View
  initialize: (options) ->
    @collection = new app.Collections.Comments
    @listenTo @collection, 'add', @addComment
    @listenTo @collection, 'reset', @addAllComments
    @url = options.url
    @collection.fetch(url: @url).done(@scroll)

  addComment: (comment) ->
    view = new app.Views.Comment(model: comment, notification: @model)
    @$el.append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)

  scroll: =>
    if position = @$('.discussion-comment.expanded:first').position()
      @$('.subject').prop 'scrollTop', position.top
