class notifications.Views.Subject extends Backbone.View
  initialize: ->
    @comments = new notifications.Collections.Comments([], url: @model.get('comments_url'))
    @listenTo @comments, 'add', @addComment
    @listenTo @comments, 'reset', @addAllComments

    @comments.fetch()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @

  addComment: (comment) ->
    view = new notifications.Views.Comment(model: comment)
    @$('.comments').append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)
