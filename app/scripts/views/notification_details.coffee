class app.Views.NotificationDetailsView extends Backbone.View
  el: '#details'
  template: JST['app/scripts/templates/notification_details.ejs']

  initialize: ->
    @render()
    @listenTo @model.subject, 'change', @renderSubject
    @model.subject.fetch()

  render: ->
    @model.trigger 'selected'
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @

  renderSubject: (subject) ->
    view = new app.Views[subject.get('type')](model: @model)
    @$('.subject').html(view.render().el)
