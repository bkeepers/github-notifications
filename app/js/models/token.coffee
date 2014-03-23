# An access token acquired via OAuth
class App.Models.Token
  @localStorage: window.localStorage

  @get: =>
    @localStorage['token']

  @set: (token) =>
    @localStorage['token'] = token

