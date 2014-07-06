class App.Views.Subject.Unknown extends Backbone.View
  template: JST['app/templates/subject/unknown.us']
  className: 'subject content'

  initialize: ->
    url = @model.notification.get('repository').html_url + '/notifications'
    @$el.html @template(url: url)

  show: ->
    
  hide: ->
