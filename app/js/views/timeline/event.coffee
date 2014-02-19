class app.Views.TimelineEvent extends Backbone.View
  template: JST['app/templates/timeline_event.us']
  className: 'conversation-event'

  render: =>
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @
