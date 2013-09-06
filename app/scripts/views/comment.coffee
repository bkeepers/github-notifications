class app.Views.Comment extends Backbone.View
  template: JST['app/scripts/templates/comment.ejs']
  className: 'discussion-comment'

  events:
    'click': 'toggle'

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
