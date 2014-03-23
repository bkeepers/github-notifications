describe 'Cache', ->
  beforeEach ->
    @cache = new Cache

  describe 'fetch', ->
    it 'sets cache with constructor', ->
      expect(@cache.fetch('key', -> 'value')).toEqual('value')
      expect(@cache.get('key')).toEqual('value')

    it 'returns exsiting value', ->
      @cache.set 'key', 'previous'
      @cache.fetch('key', -> 'new value')
      expect(@cache.get('key')).toEqual('previous')

  describe 'clean', ->
    it 'removes least recently used keys', ->
      @cache.set 'foo', 'a'
      @cache.set 'bar', 'b'
      @cache.set 'baz', 'b'
      @cache.get 'bar'
      @cache.clean(1)
      expect(@cache.keys).toEqual(['bar'])
