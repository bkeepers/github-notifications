class app.Views.Subject extends Backbone.View
  template: JST['app/templates/subject.us']
  className: 'subject content loading'

  keyboardEvents:
    'n': 'selectNext'
    'p': 'selectPrevious'

  @for: (model) ->
    app.Views[model.constructor.name] || app.Views.Subject

  initialize: (options) ->
    @notification = options.notification

    if @banner
      @bannerView = new app.Views.Banner(model: @model, notification: @notification, template: @banner)
      @listenTo @model, 'change', @bannerView.render

    @listenTo @model, 'change', @loadComments
    @render()

    @model.fetch() if @model.url

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$('.comments').append(@bannerView.el) if @banner

  loadComments: ->
    if url = @model.comments.url
      @comments = new app.Views.Comments(collection: @model.comments, model: @notification, el: @$('.comments'))
      @model.comments.on 'sync', @loaded
      @$el.append new app.Views.CreateComment(collection: @model.comments).el

  loaded: =>
    @$el.removeClass('loading')

  selectNext: ->
    comment = if @model.comments.selected
      @model.comments.next()
    else
      @model.comments.first()

    @model.comments.select comment if comment

  selectPrevious: ->
    if comment = @model.comments.prev()
      @model.comments.select comment
