# Form to create a new comment
class App.Views.CreateComment extends Backbone.View
  template: JST['app/templates/create_comment.us']
  className: 'write-content conversation-comment conversation-item write-selected'

  keyboardEvents:
    'meta+enter': 'create'

  events:
    'submit form': 'create'
    'focusin': -> @collection.select null
    'click .preview-tab': 'preview'
    'click .write-tab': 'write'

  # Initialize the comment form
  #
  # Required options:
  # collection: The collection to create the new comment on.
  initialize: ->
    @render()
    @previewContent = @$('.comment-body')
    @body = @$('[name=body]')

  render: =>
    @$el.html @template()

  create: (e) ->
    e.preventDefault()
    @collection.create(
      {body: @body.val()}
      wait: true
      success: @render
      error: @error
    )

  write: (e) ->
    e.preventDefault();
    @$el.addClass('write-selected').removeClass('preview-selected')

  preview: (e) =>
    e.preventDefault()
    @$el.removeClass('write-selected').addClass('preview-selected')
    @previewContent.html '<p>Loading preview…</p>'

    data =
      context: @collection.subject.notification.get('repository').full_name
      mode: 'gfm'
      text: @body.val()

    $.ajax(
      type: 'POST',
      url: app.endpoints.api + 'markdown',
      data: JSON.stringify(data),
    ).done(@showPreview)

  showPreview: (body) =>
    @previewContent.html body || '<p>Nothing to preview.</p>'

  error: (comment, xhr, options) =>
    @$el.addClass('error')
