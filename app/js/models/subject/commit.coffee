# See http://developer.github.com/v3/git/commits/#get-a-commit
class App.Models.Subject.Commit extends App.Models.Subject
  octicon: 'git-commit'

  createdAt: ->
    @get('commit')?.author.date || @notification.get('updated_at')

  isUnread: ->
    @isUnreadSince(@createdAt())
