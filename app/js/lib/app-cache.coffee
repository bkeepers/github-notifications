# Update app cache every 60 seconds and when leaving the page

update = ->
  applicationCache.update() unless applicationCache.status == applicationCache.UNCACHED

setInterval update, 60 * 1000
$(window).on 'beforeunload', update
