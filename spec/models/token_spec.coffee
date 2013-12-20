describe 'app.Models.Token', ->
  beforeEach ->
    @localStorage = app.Models.Token.localStorage = {}

  describe 'get', ->
    it 'gets token from localStorage', ->
      @localStorage['token'] = 'from localStorage'
      expect(app.Models.Token.get()).toEqual('from localStorage')

  describe 'set', ->
    it 'sets token in localStorage', ->
      app.Models.Token.set('foo')
      expect(@localStorage['token']).toEqual('foo')
