# View all, participating, starred or notifications by repository
class app.Views.Lists extends Backbone.View
  el: '#lists'
  template: JST['app/templates/lists.us']

  # Initialize the view
  #
  # Required options:
  # repositories - a collection of repositories to render
  initialize: (options) ->
    @render()
    @repositories = new app.Views.Repositories(collection: options.repositories)

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @
