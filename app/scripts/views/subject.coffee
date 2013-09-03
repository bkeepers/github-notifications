class app.Views.Subject extends Backbone.View
  initialize: ->
    if url = @model.get('comments_url')
      @comments = new app.Collections.Comments([], url: url)
      @listenTo @comments, 'add', @addComment
      @listenTo @comments, 'reset', @addAllComments

      @comments.fetch()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @

  addComment: (comment) ->
    view = new app.Views.Comment(model: comment)
    @$('.comments').append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)
