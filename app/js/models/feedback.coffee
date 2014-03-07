class app.Models.Feedback extends Backbone.Model
  url: 'https://api.github.com/repos/bkeepers/github-notifications/issues'
  template: JST['app/templates/feedback_body.us']

  defaults:
    labels: ['feedback']

  validate: (attrs = @attributes, options = {}) ->
    attrs.body = @template(attrs)
    @set attrs
    null
