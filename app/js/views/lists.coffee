# View all or participating or notifications by repository
class App.Views.Lists extends Backbone.View
  el: '#lists'
  template: JST['app/templates/lists.us']

  # Initialize the view
  #
  # Required options:
  # repositories - a collection of repositories to render
  initialize: (options) ->
    @render()
    @repositories = new App.Views.Repositories(collection: options.repositories)
    @filters = new App.Views.Filters(collection: options.filters)

    new App.Views.Tips()

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @
