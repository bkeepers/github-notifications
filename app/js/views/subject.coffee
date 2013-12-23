class app.Views.Subject extends Backbone.View
  template: JST['app/templates/subject.us']
  className: 'subject content loading'

  @for: (model) ->
    app.Views[model.constructor.name] || app.Views.Subject

  initialize: (options) ->
    @notification = options.notification

    @initialComment = new app.Views.Comment(model: @model, notification: @notification)
    @listenTo @model, 'change', @initialComment.render
    @listenTo @model, 'change', @loadComments
    @model.fetch()
    @render()

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$('.comments').append(@initialComment.el)

  loadComments: ->
    if url = @model.get('comments_url')
      @comments = new app.Views.Comments(model: @notification, url: url, el: @$('.comments'))
      @comments.collection.on 'sync', @loaded

  loaded: =>
    @$el.removeClass('loading')
