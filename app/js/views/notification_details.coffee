# Root view for all the details of a notification
class App.Views.NotificationDetailsView extends Backbone.View
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
    @subject = new view(model: @model.subject, notification: @model)
    @subscription = new App.Views.Subscription(model: @model.subscription)
    @render()

  render: ->
    @$el.html @template()
    @$('.actions').append @subscription.el
    @$el.append @subject.el
    @

  # Set target=_blank if it is an external link
  clickLink: (e) ->
    target = $(e.target).closest('a').get(0)
    href = target.getAttribute('href')
    target.target = '_blank' if href && href.hostname != window.location.hostname

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

  hide: ->
    @unbindKeyboardEvents()
    @subject.hide()
    @$el.removeClass('selected')

  show: ->
    @bindKeyboardEvents()
    @subject.show()
    @$el.addClass('selected')
