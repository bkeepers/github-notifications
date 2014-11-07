class App.Models.Filter extends Backbone.Model
  defaults:
    octicon: 'inbox'
    reasons: [
      'subscribed'
      'manual'
      'author'
      'comment'
      'mention'
      'team_mention'
      'state_change'
      'assign'
    ]

  initialize: ->
    @generateId()
    @on 'change:name', @generateId
    @notifications = new App.Collections.Notifications([], filter: @reasonFilter, data: @get('data'))

  generateId: (name) ->
    @set 'id', name.toLowerCase() if name = @get('name')

  reasonFilter: (model) =>
    !@get('reasons') || model.get('reason') in @get('reasons')

  read: ->
    # noop

  validate: ->
    errors = []

    errors.push('name') unless @get('name')
    errors.push('octicon') unless @get('octicon')

    errors unless errors.length == 0
