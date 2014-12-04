# View all or participating or notifications by repository
class App.Views.Lists extends View
  el: '#lists'
  template: JST['app/templates/lists.us']

  # Initialize the view
  #
  # Required options:
  # repositories - a collection of repositories to render
  initialize: (options) ->
    @render()
    @subview @repositories = new App.Views.Repositories(collection: options.repositories)
    @subview @filters = new App.Views.Filters(collection: options.filters)

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @
