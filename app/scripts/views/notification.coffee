class app.Views.Notification extends Backbone.View
  tagName: 'li'
  className: 'notification'
  template: JST['app/scripts/templates/notification.ejs']

  initialize: ->
    @listenTo @model, 'selected', @select

  render: ->
    @$el.html @template(@model.toJSON())
    # FIXME: extract this
    @$('.js-relative-time[datetime]').each ->
      if date = moment $(this).attr('datetime'), 'YYYY-MM-DDTHH:mm:ssZ'
        this.textContent = date.fromNow()
    @

  select: =>
    $('#notifications .selected').removeClass('selected')
    @$el.addClass('selected');
