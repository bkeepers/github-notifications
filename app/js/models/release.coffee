# See http://developer.github.com/v3/repos/releases/
class App.Models.Release extends App.Models.Subject
  octicon: 'tag'

  toJSON: ->
    html_url = @notification.get('repository').html_url

    _.extend super,
      tag_html_url: "#{html_url}/tree/#{@get('tag_name')}"
