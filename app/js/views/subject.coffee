# Renders the subject of a notification.
#
# This view is responsible for showing most of the relevant details of the
# thing that the notification is for, which should be an Issue, PullRequest,
# or Commit.
class App.Views.Subject extends Backbone.View
  template: JST['app/templates/subject.us']
  className: 'subject content loading'

  keyboardEvents:
    'n': 'selectNext'
    'p': 'selectPrevious'

  # Chose the appropriate view class for the given subject
  @for: (model) ->
    App.Views.Subject[model.get('type')] || App.Views.Subject

  # Required options:
  # notification - a Notification model
  # model - a Subject model
  initialize: (options) ->
    @notification = options.notification

    @bannerView = new App.Views.Banner(model: @model, template: @banner) if @banner

    @render()

    @model.ready @loadComments
    @model.fetch() if @model.url

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$('.comments').append(@bannerView.el) if @banner

  loadComments: =>
    if url = @model.comments.url
      @comments = new App.Views.Comments(collection: @model.comments, el: @$('.comments'))
      @model.comments.on 'sync', @loaded
      @$el.append new App.Views.CreateComment(collection: @model.comments).el

  loaded: =>
    @$el.removeClass('loading')

  selectNext: ->
    comment = if @model.comments.selected
      @model.comments.next()
    else
      @model.comments.first()

    comment?.select scroll: true

  selectPrevious: ->
    comment.select scroll: true if comment = @model.comments.prev()

  hide: ->
    @unbindKeyboardEvents()

  show: ->
    @bindKeyboardEvents()
