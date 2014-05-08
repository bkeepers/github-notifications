class App.Models.Event extends Backbone.Model
  showEvents: [
    'closed',
    'reopened',
    'merged',
    'referenced',
    'head_ref_deleted',
    'head_ref_restored'
  ]

  initialize: ->
    @url = @get('url')

  isUnread: ->
    @collection?.subject?.isUnreadSince(@get('created_at'))

  hideInTimeline: ->
    !_.contains @showEvents, @get('event')
