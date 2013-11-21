class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/templates/notification_details.us']

  keyboardEvents:
    'm': -> @model.subscription.toggle()
    's': -> @model.toggleStar()
    'o': -> window.open @model.subject.get('html_url'), '_blank'

  events:
    'click a': 'clickLink'

  initialize: ->
    @listenTo @model.subject, 'change', @renderSubject
    @subjectView = new app.Views[@model.subject.get('type')](model: @model.subject, notification: @model)
    @model.subject.fetch()
    @model.read()
    @render()

  render: ->
    @model.select()
    @$el.html @template(@model.toJSON())
    @$('.comments').append @subjectView.el
    app.trigger 'render', @
    new app.Views.NotificationHeader(model: @model, el: @$('header'))
    @

  renderSubject: (subject) ->
    @subjectView.render()
    if url = subject.get('comments_url')
      @comments = new app.Views.Comments(model: @model, url: url, el: @$('.comments'))

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname
