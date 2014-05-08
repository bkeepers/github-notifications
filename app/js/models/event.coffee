class App.Models.Event extends Backbone.Model
  initialize: ->
    super
    @url = @get('url')

  isUnread: ->
    @collection?.subject?.isUnreadSince(@get('created_at'))
