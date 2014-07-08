# Client-side handling of OAuth
#
# This requires a local server that responds to two routes:
#
# GET /authenticate
# returns a JSON object with OAuth client_id and scope.
#
# POST /authenticate/:code
# Uses the code to complete OAuth and return a JSON object with a token
class App.Models.OAuth
  location: window.location
  
  url: ->
    app.endpoints.web + "login/oauth/authorize"

  # Finish OAuth if there is a code in the parameters, otherwise initate OAuth
  authorize: ->
    if code = @getCode()
      @getToken(code).done(@done)
    else
      @redirect()

  # Redirect to GitHub to initiate the OAuth dance.
  #
  # options:
  # client_id - The client ID from https://github.com/settings/applications
  # scope     - The OAuth scope needed by the application.
  #             See: http://developer.github.com/v3/oauth/#scopes
  redirect: (options = app.config) ->
    @location.assign "#{@url()}?client_id=#{options.client_id}&scope=#{options.scope}"

  getCode: ->
    match = @location.href.match(/\?code=(.*)/)
    match[1] if match

  getToken: (code) ->
    app.ajax
      dataType: "json"
      type: 'POST'
      url: "/authenticate/#{code}"
      success: (data) -> App.Models.Token.set(data.token)

  done: =>
    # Redirect to get code out of URL
    @location.assign @location.pathname
