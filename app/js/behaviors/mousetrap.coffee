# Override to propogate through inputs if meta key is pressed
original = Mousetrap.stopCallback
Mousetrap.stopCallback = (event, element, shortcut) ->
  !event.metaKey && original.apply(this, arguments)
