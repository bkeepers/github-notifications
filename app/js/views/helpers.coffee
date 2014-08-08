App.Views.Helpers =
  # Create a new object that extends these helpers and then the given object
  extend: (object) ->
    _.extend {}, @, object

  pluralize: (count, noun, showCount = true) ->
    noun = "#{noun}s" unless count == 1
    if showCount
      "#{count} #{noun}"
    else
      noun
