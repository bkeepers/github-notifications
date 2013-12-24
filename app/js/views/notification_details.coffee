class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'

  keyboardEvents:
    'm': -> @model.subscription.toggle()
    'M': 'muteAndNext'
    's': -> @model.toggleStar()
    'o': -> window.open @model.subject.get('html_url'), '_blank'
    'r': (e) -> e.preventDefault(); @$('textarea').focus()

  events:
    'click a': 'clickLink'
    'click *[rel=back]': 'unfocus'

  muteAndNext: ->
    @model.subscription.toggle()
    if notification = @model.collection.next()
      Backbone.history.navigate "#n/#{notification.id}", trigger: true

  initialize: ->
    view = app.Views.Subject.for(@model.subject)
    @subject = new view(model: @model.subject, notification: @model)
    @header = new app.Views.NotificationHeader(model: @model)
    @model.select()
    @render()

  render: ->
    @$el.empty()
    @$el.append @header.el
    @$el.append @subject.el
    @$el.addClass('focused')
    @

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname

  unfocus: (e) ->
    e.preventDefault()
    @$el.removeClass('focused')
