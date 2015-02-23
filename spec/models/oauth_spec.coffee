describe 'App.Models.OAuth', ->
  beforeEach ->
    spyOn app, 'ajax'

    # Test double for window.location
    @location =
      assign: jasmine.createSpy('assign')
      search: ''
      pathname: '/foobar'

    App.Models.OAuth.prototype.location = @location

    @oauth = new App.Models.OAuth

  describe 'redirect', ->
    it 'changes window.location', ->
      @oauth.redirect(client_id: 123, scope: 'scope')
      expect(@location.assign).toHaveBeenCalledWith(
        "https://github.com/login/oauth/authorize?client_id=123&scope=scope"
      )

  describe 'getCode', ->
    it 'returns undefined if href does not contain a code', ->
      expect(@oauth.getCode()).toBe(undefined)

    it 'returns code from window.location', ->
      @location.search = 'foo=bar&code=omg'
      expect(@oauth.getCode()).toEqual('omg')
