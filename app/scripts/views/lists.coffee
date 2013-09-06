class app.Views.Lists extends Backbone.View
  el: '#lists'
  template: JST['app/scripts/templates/lists.ejs']

  initialize: (options) ->
    @render()
    @repositories = new app.Views.Repositories(collection: options.repositories)

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @
