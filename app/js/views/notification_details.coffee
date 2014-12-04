# Root view for all the details of a notification
class App.Views.NotificationDetailsView extends View
  template: JST['app/templates/notification_details.us']
  className: 'details pane'

  keyboardEvents:
    'm': -> @model.subscription.toggle()
    'M': 'muteAndNext'
    'o': 'open'
    'r': 'reply'

  events:
    'click a': 'clickLink'
    'click *[rel=back]': 'unfocus'

  # Required options:
  # model - a notification object
  initialize: ->
    view = App.Views.Subject.for(@model.subject)
    @subview @subject = new view(model: @model.subject, notification: @model)
    @subview @subscription = new App.Views.Subscription(model: @model.subscription)
    @render()
    @on 'hide', -> @$el.removeClass('selected')
    @on 'show', -> @$el.addClass('selected')

  render: ->
    @$el.html @template()
    @$('.actions').append @subscription.el
    @$el.append @subject.el
    @

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    href = e.target.getAttribute('href')
    e.target.target = '_blank' if href && href.hostname != window.location.hostname

  unfocus: (e) ->
    e.preventDefault()
    @model.unselect()

  muteAndNext: ->
    @model.subscription.toggle()
    @model.collection.next()?.select()

  # Go to the page on GitHub for this notification
  open: (e) ->
    e.preventDefault()
    window.open @subject.url(), '_blank'

  # Focus the reply textarea
  reply:(e) ->
    e.preventDefault()
    @$('textarea').focus()
