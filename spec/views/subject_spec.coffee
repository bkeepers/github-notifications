describe 'app.View.Subject', ->
  beforeEach ->
    @view = new app.Models.Subject

  describe 'for', ->
    it 'returns PullRequest', ->
      model = new app.Models.PullRequest()
      expect(app.Views.Subject.for(model)).toBe(app.Views.PullRequest)

    it 'returns Issue', ->
      model = new app.Models.Issue()
      expect(app.Views.Subject.for(model)).toBe(app.Views.Issue)

    it 'returns Commit', ->
      model = new app.Models.Commit()
      expect(app.Views.Subject.for(model)).toBe(app.Views.Commit)

    it 'returns Subject for unknown type', ->
      model = new Backbone.Model()
      expect(app.Views.Subject.for(model)).toBe(app.Views.Subject)
