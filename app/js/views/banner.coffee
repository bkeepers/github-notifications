# A view displayed above all the comments for a Subject
class App.Views.Banner extends App.Views.Comment

  # Initialize a banner view with the given template
  #
  # template - defined by subject. See Models.Issue#banner,
  #            Models.PullRequest#banner, and Models.Commit#banner
  initialize: (options) ->
    @template = options.template
    @model.ready @render

  # Ignore all events defined by the Comment view
  events: {}

  # Avoid selection state inherited from the comment view
  selected: null
  unselected: null
