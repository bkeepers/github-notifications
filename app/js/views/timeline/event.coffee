class App.Views.TimelineEvent extends Backbone.View
  className: 'conversation-event conversation-item'

  render: =>
    @$el.addClass("conversation-event-#{@model.get('event')}")

    template = JST["app/templates/timeline/#{@model.get('event')}.us"]

    data = @model.toJSON()
    data.subject = @model.collection.subject.toJSON()
    @$el.html template(data)
    app.trigger 'render', @
    @
