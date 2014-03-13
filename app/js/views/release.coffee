class app.Views.Release extends app.Views.Subject
  banner: JST['app/templates/release.us']

  render: ->
    result = super
    @loaded()
    result
