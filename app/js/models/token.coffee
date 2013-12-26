# An access token acquired via OAuth
class app.Models.Token
  @localStorage: window.localStorage

  @get: =>
    @localStorage['token']

  @set: (token) =>
    @localStorage['token'] = token

