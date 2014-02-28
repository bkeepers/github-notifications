class app.Models.PullRequest extends app.Models.Subject
  octicon: 'git-pull-request'
  display_type: 'pull request'

  initialize: ->
    super

    @on 'change', ->
      @events.url = @get('issue_url') + '/events'
