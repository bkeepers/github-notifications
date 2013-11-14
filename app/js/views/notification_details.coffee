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
    @render()
    @listenTo @model.subject, 'change', @renderSubject
    @model.subject.fetch()

    @model.read()

  render: ->
    @model.select()
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    new app.Views.NotificationHeader(model: @model, el: @$('header'))
    @

  renderSubject: (subject) ->
    view = new app.Views[subject.get('type')](model: subject, notification: @model)
    @$('.comments').empty().append(view.render().el)
    if url = subject.get('comments_url')
      @comments = new app.Views.Comments(model: @model, url: url, el: @$('.comments'))

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname
