# Root view for all the details of a notification
class App.Views.NotificationDetailsView extends Backbone.View
  template: JST['app/templates/notification_details.us']
  className: 'pane'

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
    window.open @subject.url(), '_blank'

  # Focus the reply textarea
  reply:(e) ->
    e.preventDefault()
    @$('textarea').focus()

  hide: ->
    @$el.removeClass('focused')
    @unbindKeyboardEvents()
    # FIXME: find a better way to give animation time to finish. This can leave
    # the view in an inconsistent state if this model is selected again before
    # the timeout fires.
    setTimeout =>
      @$el.detach()
      @subject.hide()
    , 300

  show: ->
    @bindKeyboardEvents()
    @subject.show()
    @$el.addClass('focused')
