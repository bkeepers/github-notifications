describe 'App.Models.OAuth', ->
  beforeEach ->
    spyOn app, 'ajax'
    app.configure web_url: 'https://github.com/'

    # Test double for window.location
    @location =
      assign: jasmine.createSpy('assign')
      href: '/foobar'
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
      @location.href = '/foo?code=omg'
      expect(@oauth.getCode()).toEqual('omg')
