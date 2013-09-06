class app.Views.Subject extends Backbone.View
  initialize: ->
    if url = @model.subject.get('comments_url')
      @comments = new app.Collections.Comments([], url: url)
      @listenTo @comments, 'add', @addComment
      @listenTo @comments, 'reset', @addAllComments

      @comments.fetch()

  render: ->
    @$el.html @template(@model.subject.toJSON())
    app.trigger 'render', @
    @

  addComment: (comment) ->
    view = new app.Views.Comment(model: comment, last_read_at: @model.get('last_read_at'))
    @$('.comments').append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)
