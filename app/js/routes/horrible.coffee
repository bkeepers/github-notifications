# Everything about this router is horrible. All of it will be refactored out and
# some glorious day this nastiness can be deleted. Instead of trigging routes
# and performing logic in them, the router should just call methods on the model
# to put the app in the desired state.
# See http://lostechies.com/derickbailey/2011/08/28/dont-execute-a-backbone-js-route-handler-from-your-code/
class App.Routers.Horrible extends Backbone.Router
  routes:
    'participating': 'participating'
    'all': 'all'
    'r/:id': 'repository'
    'feedback': 'feedback'

  initialize: (options)->
    @collection = options.notifications
    @repositories = options.repositories

    @on 'route', @selectItem

    @view = new App.Views.Threads(collection: @collection)
    @view.render()

  participating: ->
    @view.load(data: {participating: true})

  all: ->
    @view.load()

  repository: (id) ->
    model = @repositories.get(id)
    return unless model
    model.select()
    @view.load(url: model.notifications_url())

  feedback: ->
    new App.Views.Feedback().render()

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    if (item = $('#lists').find("a[href='#{window.location.hash}']")).length
      $('#lists').find('.selected').removeClass('selected')
      item.addClass('selected')
