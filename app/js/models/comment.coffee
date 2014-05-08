# See:
# * http://developer.github.com/v3/issues/comments/
# * http://developer.github.com/v3/repos/comments/#list-comments-for-a-single-commit
class App.Models.Comment extends Backbone.Model

  isUnread: ->
    !@collection || @collection.subject.isUnreadSince(@get('created_at'))
