class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/scripts/templates/notification_details.ejs']

  keyboardEvents:
    'm': -> @model.subscription.toggle()
    's': -> @model.toggleStar()
    'o': -> window.open @model.subject.get('html_url'), '_blank'

  events:
    'click a': 'clickLink'

  initialize: ->
    @render()
    @listenTo @model.subject, 'change', @renderSubject
    @model.subject.fetch()

    @comments = new app.Collections.Comments
    @listenTo @comments, 'add', @addComment
    @listenTo @comments, 'reset', @addAllComments

    @model.read() unless app.isDevelopment()

  render: ->
    @model.select()
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    new app.Views.NotificationHeader(model: @model, el: @$('header'))
    @

  renderSubject: (subject) ->
    view = new app.Views[subject.get('type')](model: subject, notification: @model)
    @$('.comments').empty().append(view.render().el)
    @comments.fetch(url: url).then(@scroll) if url = subject.get('comments_url')

  addComment: (comment) ->
    view = new app.Views.Comment(model: comment, notification: @model)
    @$('.comments').append(view.render().el)

  addAllComments: ->
    @collection.each(@add, @)

  scroll: =>
    if position = @$('.discussion-comment.expanded:first').position()
      @$('.subject').prop 'scrollTop', position.top

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname
