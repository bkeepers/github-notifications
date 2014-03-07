class app.Models.Feedback extends Backbone.Model
  url: 'https://api.github.com/repos/bkeepers/github-notifications/issues'
  template: JST['app/templates/feedback_body.us']

  defaults:
    labels: ['feedback']

  validate: (attrs = @attributes, options = {}) ->
    if attrs.text
      [attrs.title, body...] = attrs.text.split("\n")
      attrs.body = body.join("\n")

      if attrs.title.length > 50
        attrs.body = "...#{attrs.title.substr(50)}\n#{attrs.body}"
        attrs.title = attrs.title.substr(0, 50) + "..."

      attrs.body = @template(attrs)
      delete attrs.text
      @set attrs

    null
