# The `Link` header includes pagination, like:
# <https://url?page=1>; rel="first", <https://url?page=2>; rel="prev"
class App.Models.Link
  regex: /<([^>]*)>; ?rel="([^"]*)"/

  constructor: (text) ->
    match = text.match(@regex)
    @href = match[1]
    @rel = match[2]
