class app.Views.Comments extends Backbone.View
  initialize: ->
    @listenTo @collection, 'add', @addComment
    @listenTo @collection, 'reset', @addAllComments
    @fetch()

  fetch: (url = @collection.url) ->
    @collection.fetch(reset: false, remove: false).done(@scroll).done(@paginate)

  paginate: (data, options, xhr) =>
    @fetch(link) if link = @nextLink(xhr.getResponseHeader("Link"))

  nextLink: (header) =>
    return unless header
    links = _.map header.split(/\s*,\s*/), (link) => new app.Models.Link(link)
    _.find links, (link) -> link.rel == 'next'

  addComment: (comment) ->
    view = new app.Views.Comment(model: comment, notification: @model)
    @$el.append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)

  scroll: =>
    if position = @$('.conversation-comment.expanded:first').position()
      @$el.closest('.subject').prop 'scrollTop', position.top
