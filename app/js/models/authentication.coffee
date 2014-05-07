class App.Models.Authentication
  # callback - function to call once authentication is done
  constructor: (callback) ->
    $(document).ajaxError @error

    if App.Models.Token.get()?
      @done(callback)
    else
      @oauth()

  oauth: ->
    new App.Models.OAuth().authorize()

  # unset the token if the API responds with a 401, and try to re-authenticate.
  error: (event, xhr) =>
    if xhr.status is 401
      App.Models.Token.set(null)
      @oauth()

  done: (callback) ->
    jQuery.ajaxPrefilter (options, originalOptions, xhr) =>
      xhr.setRequestHeader 'Authorization', "token #{App.Models.Token.get()}"
    callback()
