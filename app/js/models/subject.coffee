class app.Models.Subject extends Backbone.Model
  @for: (subject) ->
    model = app.Models[subject.type] || app.Models.Subject
    new model(subject)

  initialize: ->
    @url = @get('url')
    @comments = new app.Collections.Comments
    @on 'change', ->
      @comments.add @ if @get('body_html')
      @comments.url = @get('comments_url')

  toJSON: ->
    _.extend super, octicon: @octicon
