class app.Views.Banner extends app.Views.Comment
  events: {} # clear out events

  initialize: (options) ->
    @template = options.template
    super
