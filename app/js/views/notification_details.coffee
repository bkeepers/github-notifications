class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/templates/notification_details.us']

  keyboardEvents:
    'm': -> @model.subscription.toggle()
    'M': 'muteAndNext'
    's': -> @model.toggleStar()
    'o': -> window.open @model.subject.get('html_url'), '_blank'

  events:
    'click a': 'clickLink'
    'click *[rel=back]': 'unfocus'

  muteAndNext: ->
    @model.subscription.toggle()
    if notification = @model.collection.next()
      Backbone.history.navigate "#n/#{notification.id}", trigger: true

  initialize: ->
    @listenTo @model.subject, 'change', @renderSubject
    @subjectView = new app.Views[@model.subject.get('type')](model: @model.subject, notification: @model)
    @model.subject.fetch()
    @model.read()
    @render()

  loaded: =>
    @subjectView.render()
    @$('.content').removeClass('loading')

  render: ->
    @model.select()
    @$el.html @template(@model.toJSON())
    @$('.content').addClass('loading')
    @$('.comments').append @subjectView.el
    app.trigger 'render', @
    @$el.addClass('focused')
    new app.Views.NotificationHeader(model: @model, el: @$('header'))
    @

  renderSubject: (subject) ->
    if url = subject.get('comments_url')
      @comments = new app.Views.Comments(model: @model, url: url, el: @$('.comments'))
      @comments.collection.on 'sync', @loaded

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname

  unfocus: (e) ->
    e.preventDefault()
    @$el.removeClass('focused')
