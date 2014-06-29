# Manages selection of Filters and Repositories
#
# Triggers:
# - filter:selected       - with a Filter
# - filter:unselected     - with a Filter
# - repository:selected   - with a Repository
# - repository:unselected - with a Repository
#
# Listens for:
# - filter:select         - Selects a filter with the given id
# - repository:select     - Selects a Repository with the given full name
class App.Controllers.Filters
  # Cache for recently loaded views
  cache: new Cache(5)

  constructor: (options) ->
    _.extend @, Backbone.Events

    @vent = options.vent
    @filters = options.filters
    @repositories = options.repositories

    @listenTo @filters, 'selected', (model) =>
      @vent.trigger 'filter:selected', model
    @listenTo @repositories, 'selected', (model) =>
      @vent.trigger 'repository:selected', model
    @listenTo @filters, 'unselected', (model) =>
      @vent.trigger 'filter:unselected', model
    @listenTo @repositories, 'unselected', (model) =>
      @vent.trigger 'repository:unselected', model

    @listenTo @vent, 'filter:select', @selectFilter
    @listenTo @vent, 'repository:select', @selectRepository

    @listenTo @vent, 'filter:selected repository:selected', @show
    @listenTo @vent, 'filter:unselected repository:unselected', @hide

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

  selectRepository: (name) ->
    @filters.selected?.unselect()
    @repositories.findByName(name)?.select()

  selectFilter: (id) ->
    @repositories.selected?.unselect()
    @filters.get(id)?.select()

  show: (filter) =>
    return unless filter

    controller = @cache.fetch filter.cid, =>
      new App.Controllers.Notifications(@vent, filter.notifications)

    controller.show()

  hide: (model) ->
    @cache.get(model.cid)?.hide()
