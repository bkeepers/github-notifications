class app.Views.Authenticate extends Backbone.View
  scope: 'repo,user'

  initialize: =>
    if token = localStorage['token']
      @done(token: token)
    else if code = @oauthCode()
      @getToken(code)
    else
      $.getJSON "/authenticate", (data) ->
        window.location = "https://github.com/login/oauth/authorize?client_id=#{data.client_id}&scope=#{data.scope}"

  getToken: (code) ->
    $.ajax
      dataType: "json",
      type: 'POST'
      url: "/authenticate/#{code}",
      success: @storeToken

  oauthCode: ->
    match = window.location.href.match(/\?code=(.*)/)
    match[1] if match

  storeToken: (data) ->
    localStorage['token'] = data.token
    # Redirect to get code out of URL
    window.location = window.location.pathname

  done: (data) ->
    jQuery.ajaxPrefilter (options, originalOptions, xhr) =>
      xhr.setRequestHeader 'Authorization', "token #{data.token}"
    app.ready()
