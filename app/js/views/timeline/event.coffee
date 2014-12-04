class App.Views.TimelineEvent extends View
  className: 'conversation-event conversation-item conversation-content'

  render: =>
    @$el.addClass("conversation-event-#{@model.get('event')}")

    template = JST["app/templates/timeline/#{@model.get('event')}.us"]

    data = @model.toJSON()
    data.subject = @model.collection.subject.toJSON()
    # FIXME: YUCK
    data.repository_html_url = @model.collection.subject.notification.get('repository').html_url
    @$el.html template(data)
    app.trigger 'render', @
    @
