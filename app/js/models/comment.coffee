# See:
# * http://developer.github.com/v3/issues/comments/
# * http://developer.github.com/v3/repos/comments/#list-comments-for-a-single-commit
class App.Models.Comment extends Backbone.Model

  isUnread: ->
    !@collection?.last_read_at ||
      moment(@collection.last_read_at) < moment(@get('created_at'))
