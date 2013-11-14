class app.Views.Authenticate extends Backbone.View
  scope: 'repo,user'
  el: '#authenticate'
  template: JST['app/templates/authenticate.us']

  events:
    'submit form': 'submit'

  initialize: =>
    if @token = localStorage['token']
      @done()
    else
      @render()

  render: ->
    @$el.html(@template())
    @

  submit: (e) =>
    e.preventDefault()

    @token = @$('input[name=token]').val()

    $.ajax
       url: "https://api.github.com/user"
       headers:
         'Authorization': "token #{@token}"
       success: @success
       error: @error

  done: ->
    jQuery.ajaxPrefilter (options, originalOptions, xhr) =>
      xhr.setRequestHeader 'Authorization', "token #{@token}"
    app.ready()
    @remove()

  success: (user) =>
    localStorage['token'] = @token
    @done()

  error: =>
    alert('Nope!')
