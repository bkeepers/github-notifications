refreshRelativeTimes = (container = document) ->
  for el in $(container).find '.js-relative-time[datetime]'
    if date = moment $(el).attr('datetime'), 'YYYY-MM-DDTHH:mm:ssZ'
      el.textContent = date.fromNow()
  return

app.on 'render', (view) ->
  refreshRelativeTimes(view.el)

# Refresh relative dates every min
setInterval refreshRelativeTimes, 60000
