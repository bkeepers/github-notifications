describe 'App.Models.Token', ->
  beforeEach ->
    @localStorage = App.Models.Token.localStorage = {}

  describe 'get', ->
    it 'gets token from localStorage', ->
      @localStorage['token'] = 'from localStorage'
      expect(App.Models.Token.get()).toEqual('from localStorage')

  describe 'set', ->
    it 'sets token in localStorage', ->
      App.Models.Token.set('foo')
      expect(@localStorage['token']).toEqual('foo')
