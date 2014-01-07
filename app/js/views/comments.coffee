# Manage list of comment views
class app.Views.Comments extends Backbone.View
  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @fetch()
    @addAll()

  # Fetch comments for the given url without reseting existing comments.
  fetch: (url = @collection.url) ->
    @collection.fetch(url: url, reset: false, remove: false).done(@scroll).done(@paginate)

  # Ajax callback to fetch next page of comments if the link exists.
  paginate: (data, options, xhr) =>
    @fetch(link) if link = @nextLink(xhr.getResponseHeader("Link"))

  # Parse the Link header, looking for rel=next
  nextLink: (header) =>
    return unless header
    links = _.map header.split(/\s*,\s*/), (link) => new app.Models.Link(link)
    _.find links, (link) -> link.rel == 'next'

  # Render the given commment
  add: (comment) ->
    view = new app.Views.Comment(model: comment, notification: @model)
    @$el.append(view.render().el)

  # Render all comments in the collection
  addAll: ->
    @collection.each(@add, @)

  # Scroll to the first expanded comment
  scroll: =>
    if position = @$('.conversation-comment.expanded:first').position()
      @$el.closest('.subject').prop 'scrollTop', position.top
