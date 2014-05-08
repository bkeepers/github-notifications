# Form to create a new comment
class App.Views.CreateComment extends Backbone.View
  template: JST['app/templates/create_comment.us']
  className: 'write-content conversation-comment conversation-item conversation-content'

  keyboardEvents:
    'meta+enter': 'create'

  events:
    'submit form': 'create'
    'focusin': -> @collection.select null

  # Initialize the comment form
  #
  # Required options:
  # collection: The collection to create the new comment on.
  initialize: ->
    @render()

  render: =>
    @$el.html @template()

  create: (e) ->
    e.preventDefault()
    @collection.create(
      {body: @$('[name=body]').val()}
      wait: true
      success: @render
      error: @error
    )

  error: (comment, xhr, options) =>
    @$el.addClass('error')
