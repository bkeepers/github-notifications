class app.Views.Banner extends app.Views.Comment
  initialize: (options) ->
    @template = options.template
    super

  events: {} # clear out events

  # Don't select banner
  selected: null
  unselected: null
