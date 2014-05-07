describe 'App.Views.TimelineEvent', ->
  beforeEach ->
    @issue = new App.Models.Subject.Issue
    @pull = new App.Models.Subject.PullRequest(
      head: {label: 'github:feature-branch'},
      base: {label: 'github:master'}
    )

    @event = new App.Models.Event(payload)

    @event.collection = {subject: @issue}
    @view = new App.Views.TimelineEvent(model: @event)

  text = ($el) ->
    $el.text().replace(/\s+/g, ' ')

  describe 'closed', ->
    it 'renders for an issue', ->
      @view.render()
      expect(text(@view.$el)).toMatch(/octocat closed the issue/)

    it 'renders for a pull request', ->
      @event.collection.subject = @pull
      @view.render()
      expect(text(@view.$el)).toMatch(/octocat closed the pull request/)

  describe 'reopened', ->
    beforeEach ->
      @event.set event: 'reopened'

    it 'renders for an issue', ->
      @view.render()
      expect(text(@view.$el)).toMatch(/octocat reopened the issue/)

    it 'renders for a pull request', ->
      @event.collection.subject = @pull
      @view.render()
      expect(text(@view.$el)).toMatch(/octocat reopened the pull request/)

  describe 'subscribed', ->
    beforeEach -> @event.set event: 'subscribed'

    it 'renders nothing', ->
      expect(text(@view.render().$el)).toEqual('')

  describe 'merged', ->
    beforeEach ->
      @event.collection.subject = @pull
      @event.set event: 'merged'

    it 'renders', ->
      @view.render()
      expect(text(@view.$el)).toMatch(/octocat merged commit 6dcb09b5 into github:master from github:feature-branch/)

  describe 'referenced', ->
    beforeEach ->
      @event.set event: 'referenced'

    # TODO: item references (currently missing from GitHub API)

    describe 'a commit', ->
      # TODO: link to commit

      it 'renders', ->
        @view.render()
        expect(text(@view.$el)).toMatch(/referenced this issue from commit 6dcb09b5/)

  # TODO: mentioned
  # TODO: assigned
  # TODO: head_ref_restored
  # TODO: head_ref_deleted

  payload = {
    "id": 1,
    "url": "https://api.github.com/repos/octocat/Hello-World/issues/events/1",
    "actor": {
      "login": "octocat",
      "id": 1,
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "somehexcode",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "type": "User",
    },
    "event": "closed",
    "commit_id": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
    "created_at": "2011-04-14T16:00:49Z"
  }
