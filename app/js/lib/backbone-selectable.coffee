_.extend Backbone.Collection.prototype,
  # Select the given model.
  #
  # Triggers the 'unselected' event on the previously selected model, the
  # 'selected' event on the given model, and the 'selected' event on the
  # collection.
  #
  #     collection = new Backbone.Collection
  #     model = collection.create({name: 'Selectable Model'})
  #
  #     model.on 'selected', (previous, options) ->
  #       console.log 'selected', @ if options.debug
  #
  #     model.on 'unselected', (selected, options) ->
  #       console.log 'unselected', @ if options.debug
  #
  #     collection.select model, debug: true
  #
  # model - a model in this collection, or null to unselect
  # args... - arguments passed to the events.
  select: (model, args...) ->
    previous = @selected
    @selected = model
    previous.trigger 'unselected', model, args... if previous
    model.trigger 'selected', previous, args... if model
    @trigger 'selected', model, previous, args...

  next: ->
    index = @indexOf(@selected)
    @at index + 1 if index >= 0

  prev: ->
    index = @indexOf(@selected)
    @at index - 1


_.extend Backbone.Model.prototype,
  select: (args...) ->
    @collection?.select(@, args...)

  unselect: (args...) ->
    @collection?.select(null, args...)

  isSelected: ->
    @collection?.selected == @
