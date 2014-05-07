class App.Models.Subject.PullRequest extends App.Models.Subject
  octicon: 'git-pull-request'
  display_type: 'pull request'

  initialize: ->
    super

    @on 'change', ->
      @events.url = @get('issue_url') + '/events'
