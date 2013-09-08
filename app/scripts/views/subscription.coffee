class app.Views.Subscription extends Backbone.View
  template: JST['app/scripts/templates/subscription.ejs']

  events:
    'click .mute':   -> @model.mute()
    'click .unmute': -> @model.unmute()

  initialize: ->
    # Results in a 404 if a subscription doesn't exist for this thread.
    @model.fetch()
    @listenTo @model, 'change', @render
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
