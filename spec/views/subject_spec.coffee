describe 'App.Views.Subject', ->
  beforeEach ->
    @view = new App.Models.Subject

  describe 'for', ->
    it 'returns PullRequest', ->
      model = new App.Models.Subject(type: 'PullRequest')
      expect(App.Views.Subject.for(model)).toBe(App.Views.PullRequest)

    it 'returns Issue', ->
      model = new App.Models.Subject(type: 'Issue')
      expect(App.Views.Subject.for(model)).toBe(App.Views.Issue)

    it 'returns Commit', ->
      model = new App.Models.Subject(type: 'Commit')
      expect(App.Views.Subject.for(model)).toBe(App.Views.Commit)

    it 'returns Subject for unknown type', ->
      model = new Backbone.Model()
      expect(App.Views.Subject.for(model)).toBe(App.Views.Subject)
