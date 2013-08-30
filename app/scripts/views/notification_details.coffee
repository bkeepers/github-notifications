class notifications.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/scripts/templates/notification_details.ejs']

  initialize: ->
    @render()
    @listenTo @model.subject, 'change', @renderSubject
    @model.subject.fetch()

  render: ->
    @$el.html @template(@model.toJSON())
    @

  renderSubject: (subject) ->
    console.log 'rendering subject', subject.view
    @$('.subject').html(subject.view.render().el)
