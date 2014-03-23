class App.Views.Release extends App.Views.Subject
  banner: JST['app/templates/release.us']

  render: ->
    result = super
    @loaded()
    result
