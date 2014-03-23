# A simple LRU cache
class @Cache
  constructor: (@size = 20) ->
    @keys = []
    @objects = {}

  # Fetch a value or set it if it does not exist.
  #
  # key - The cache key
  # constructor - a function to call if the key is not set
  fetch: (key, constructor) ->
    @get(key) || @set(key, constructor())

  # Get the cached value
  get: (key) ->
    @touch(key)
    @objects[key]

  # Set the cached value
  set: (key, object) ->
    @objects[key] = object
    @touch(key)
    @clean()
    object

  # Unset the key
  unset: (key) ->
    @objects[key]?.remove?()
    delete @objects[key]
    @keys = _.without(@keys, key)

  # Touch the given key
  touch: (key) ->
    @keys = _.without(@keys, key)
    @keys.push(key)

  # Remove all but n of the least recently used objects
  clean: (n = @size) ->
    @unset(key) for key in @keys.slice(0, -n)
