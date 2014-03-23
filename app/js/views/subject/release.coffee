class App.Views.Subject.Release extends App.Views.Subject
  banner: JST['app/templates/subject/release.us']

  render: ->
    result = super
    @loaded()
    result
