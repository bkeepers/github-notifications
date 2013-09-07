class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/scripts/templates/notification_details.ejs']

  initialize: ->
    @render()
    @listenTo @model.subject, 'change', @renderSubject
    @model.subject.fetch()

    @comments = new app.Collections.Comments
    @listenTo @comments, 'add', @addComment
    @listenTo @comments, 'reset', @addAllComments

    @model.read()

  render: ->
    @model.select()
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
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
