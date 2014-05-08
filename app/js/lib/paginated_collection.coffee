class @PaginatedCollection extends Backbone.Collection
  # The `Link` header includes pagination, like:
  # <https://url?page=1>; rel="first", <https://url?page=2>; rel="prev"
  class Link
    regex: /<([^>]*)>; ?rel="([^"]*)"/

    @fromHeader: (header) ->
      _.map header.split(/\s*,\s*/), (link) -> new Link(link)

    constructor: (text) ->
      match = text.match(@regex)
      @href = match[1]
      @rel = match[2]

  # Override fetch method to check for pagination urls
  fetch: ->
    super.done(@paginate)

  # Ajax callback to fetch next page of comments if the link exists.
  paginate: (data, options, xhr) =>
    if link = @nextLink(xhr.getResponseHeader("Link"))
      @fetch(url: link.href, reset: false, remove: false)
    else
      @trigger 'paginated'

  # Parse the Link header, looking for rel=next
  nextLink: (header) =>
    return unless header
    _.find Link.fromHeader(header), (link) -> link.rel == 'next'
