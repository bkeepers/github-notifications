# Form to create a new comment
class App.Views.CreateComment extends Backbone.View
  template: JST['app/templates/create_comment.us']
  className: 'write-content conversation-comment conversation-item write-selected'

  class Buttons extends Backbone.View
    template: JST['app/templates/create_comment_buttons.us']
    initialize: ->
      @listenTo @model, 'change:state', @render
      @render()

    render: ->
      @$el.html @template(state: @model.get('state'))

  keyboardEvents:
    'meta+enter': 'create'

  events:
    'focusin': -> @collection.select null
    'change form': 'trackDirty'
    'keyup form': 'trackDirty'
    'click .preview-tab': 'preview'
    'click .write-tab': 'write'
    'click button[name=open]': 'open'
    'click button[name=close]': 'close'
    'submit form': 'create'

  # Initialize the comment form
  #
  # Required options:
  # collection: The collection to create the new comment on.
  initialize: ->
    @render()

  render: =>
    @$el.html @template(@collection.subject.toJSON())
    @$('.form-actions').html(new Buttons(model: @collection.subject).el)
    @form = @$('form')
    @previewContent = @$('.comment-body')
    @body = @$('[name=body]')

  create: (e) ->
    e.preventDefault()
    return if $.trim(@body.val()) == ''
    @collection.create(
      {body: @body.val()}
      wait: true
      success: @render
      error: @error
    )

  open: (e) ->
    @create(e)
    @collection.subject.save({state:'open'}, {patch:true})

  close: (e) ->
    @create(e)
    @collection.subject.save({state:'closed'}, {patch:true})

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

  trackDirty: ->
    if $.trim(@body.val()) == ''
      @form.removeClass('commenting')
    else
      @form.addClass('commenting')
