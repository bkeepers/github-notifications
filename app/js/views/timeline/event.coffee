class App.Views.TimelineEvent extends Backbone.View
  className: 'conversation-event'

  render: =>
    template = JST["app/templates/timeline/#{@model.get('event')}.us"]
    return @ unless template

    data = @model.toJSON()
    data.subject = @model.collection.subject.toJSON()
    @$el.html template(data)
    app.trigger 'render', @
    @
