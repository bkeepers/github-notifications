class app.Views.Subject extends Backbone.View
  template: JST['app/templates/subject.us']
  className: 'subject content loading'

  # Is the model also the initial comment? This is true for Issues and
  # PullRequests, but not for Commits
  isInitialComment: true

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

    if @isInitialComment
      @initialCommentView = new app.Views.Comment(model: @model, notification: @notification)
      @listenTo @model, 'change', @initialCommentView.render

    @listenTo @model, 'change', @loadComments
    @render()

    @model.fetch() if @model.url

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$('.comments').append(@bannerView.el) if @banner
    @$('.comments').append(@initialCommentView.el) if @isInitialComment

  loadComments: ->
    if url = @model.get('comments_url')
      commentsView = new app.Views.Comments(model: @notification, url: url, el: @$('.comments'))
      @comments = commentsView.collection
      @comments.on 'sync', @loaded
      @comments.on 'selected', @selected
      @$el.append new app.Views.CreateComment(collection: @comments).el

  loaded: =>
    @$el.removeClass('loading')

  selectNext: ->
    @comments.select @comments.next() || @comments.first() if @comments

  selectPrevious: ->
    @comments.select @comments.prev() || @comments.last() if @comments
