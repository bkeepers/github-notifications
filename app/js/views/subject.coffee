# Renders the subject of a notification.
#
# This view is responsible for showing most of the relevant details of the
# thing that the notification is for, which should be an Issue, PullRequest,
# or Commit.
class App.Views.Subject extends Backbone.View
  template: JST['app/templates/subject.us']
  className: 'subject content loading'

  # Chose the appropriate view class for the given subject
  @for: (model) ->
    App.Views.Subject[model.get('type')] || App.Views.Subject

  # Required options:
  # notification - a Notification model
  # model - a Subject model
  initialize: (options) ->
    @notification = options.notification

    @bannerView = new App.Views.Banner(model: @model, template: @banner) if @banner
    @timelineView = new App.Views.Timeline(collection: @model.timeline)

    @listenTo @model, 'change', => @model.timeline.fetch()

    @render()

    @model.ready @loaded
    @model.fetch() if @model.url

  render: ->
    @$el.html @template(@model.toJSON())
    @$('.comments').append(@bannerView.el) if @banner
    @$('.comments').append(@timelineView.el)
    app.trigger 'render', @

  loaded: =>
    if @model.comments.url
      @$el.append new App.Views.CreateComment(collection: @model.comments).el

    @$el.removeClass('loading')

  hide: ->
    @timelineView.unbindKeyboardEvents()

  show: ->
    @timelineView.bindKeyboardEvents()
