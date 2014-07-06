moment.lang 'en',
  relativeTime :
    future: '%s'
    past:   '%s'
    s:      'now'
    m:      '1m'
    mm:     '%dm'
    h:      '1h'
    hh:     '%dh'
    d:      '1d'
    dd:     '%dd'
    M:      '1M'
    MM:     '%dM'
    y:      '1y'
    yy:     '%dy'

refreshRelativeTimes = (container = document) ->
  for el in $(container).find '.js-relative-time[datetime]'
    if date = moment $(el).attr('datetime'), 'YYYY-MM-DDTHH:mm:ssZ'
      el.textContent = date.fromNow()
      el.title = date.format("dddd, MMMM Do YYYY, h:mm:ss a")
  return

app.on 'render', (view) ->
  refreshRelativeTimes(view.el)

# Refresh relative dates every min
setInterval refreshRelativeTimes, 60000
