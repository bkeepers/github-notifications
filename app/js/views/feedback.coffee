class app.Views.Feedback extends Backbone.View
  template: JST['app/templates/feedback.us']
  confirmTemplate: JST['app/templates/feedback_confirm.us']

  events:
    'submit form': 'submit'
    'click .close': 'remove'
    'click .overlay': 'closeIfClickedOutside'

  initialize: ->
    @model = new app.Models.Feedback
    @listenTo @model, 'sync', @confirm

  render: ->
    @$el.html @template()
    $(document.body).append @el

  submit: (e) ->
    e.preventDefault()
    @model.save title: @$('[name=title]').val(), body: @$('[name=body]').val()

  confirm: =>
    @$el.html @confirmTemplate(@model.toJSON())

  remove: (e) =>
    e.preventDefault() if e
    window.history.back()
    super

  closeIfClickedOutside: (e) =>
    @remove(e) if $(e.target).is('.overlay')
