class app.Views.CreateComment extends Backbone.View
  template: JST['app/templates/create_comment.us']
  className: 'write-content conversation-comment conversation-content'

  keyboardEvents:
    'meta+enter': 'create'

  events:
    'submit form': 'create'

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
