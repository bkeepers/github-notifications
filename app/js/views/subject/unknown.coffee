class App.Views.Subject.Unknown extends Backbone.View
  template: JST['app/templates/subject/unknown.us']
  className: 'subject content'

  initialize: ->
    @$el.html @template(url: @url())

  url: ->
    @model.get('html_url') || @model.notification.get('repository').html_url + '/notifications'

  show: ->

  hide: ->
