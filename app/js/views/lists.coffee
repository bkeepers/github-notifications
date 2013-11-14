class app.Views.Lists extends Backbone.View
  el: '#lists'
  template: JST['app/templates/lists.us']

  initialize: (options) ->
    @render()
    @repositories = new app.Views.Repositories(collection: options.repositories)

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @
