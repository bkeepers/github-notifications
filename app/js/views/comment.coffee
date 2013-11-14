class app.Views.Comment extends Backbone.View
  template: JST['app/templates/comment.us']
  className: 'conversation-comment'

  events:
    'click .conversation-meta': 'toggle'

  initialize: (options) ->
    @notification = options.notification

  render: ->
    @$el.html @template(@model.toJSON())
    @$el.addClass if @unread() then 'expanded' else 'collapsed'
    app.trigger 'render', @
    @

  unread: ->
    last_read_at = @notification.get('last_read_at')
    !last_read_at || moment(last_read_at) < moment(@model.get('created_at'))

  toggle: ->
    @$el.toggleClass('collapsed expaneded')
