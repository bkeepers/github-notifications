# FIXME: move to App.Views.Filters.Create
class App.Views.FiltersCreate extends Backbone.View
  template: JST['app/templates/filters/create.us']

  octicons: '
    alert beer book briefcase broadcast browser bug calendar check circuit-board clock cloud-download code comment-discussion dashboard
    database device-camera device-camera-video device-desktop device-mobile diff diff-added diff-ignored diff-modified diff-removed diff-renamed ellipsis eye file-binary file-code file-directory file-media file-pdf file-submodule file-symlink-directory file-symlink-file file-text file-zip flame fold gear gift gist gist-secret git-branch git-commit git-compare git-merge git-pull-request globe graph heart history home horizontal-rule hourglass hubot inbox info issue-closed issue-opened issue-reopened jersey jump-down jump-left jump-right jump-up key keyboard law light-bulb link link-external list-ordered list-unordered location lock logo-github mail mail-read mail-reply mark-github markdown megaphone mention microscope milestone mirror mortar-board move-down move-left move-right move-up mute no-newline octoface organization package paintcan pencil person pin playback-fast-forward playback-pause playback-play playback-rewind plug plus podium primitive-dot primitive-square pulse puzzle question quote radio-tower repo repo-clone repo-force-push repo-forked repo-pull repo-push rocket rss ruby screen-full screen-normal search server settings sign-in sign-out split squirrel star steps stop sync tag telescope terminal three-bars tools trashcan triangle-down triangle-left triangle-right triangle-up unfold unmute versions x zap
  '.trim().split(/\s+/)

  # https://developer.github.com/v3/activity/notifications/#notification-reasons
  reasons:
    'subscribed':	  'you are watching the repository'
    'manual':	      'you specifically decided to watch the item (via an Issue or Pull Request)'
    'author':	      'you created the item'
    'comment':	    'you commented on the item'
    'mention':	    'you were specifically @mentioned in the content'
    'team_mention':	'you were on a team that was mentioned (like @org/team)'
    'state_change':	'you changed the item state (like closing an Issue or merging a Pull Request)'
    'assign':	      'you were assigned to the Issue'

  events:
    'submit form': 'save'
    'click .close,.overlay': 'cancel'

  render: ->
    @$el.html @template(octicons: @octicons, reasons: @reasons, types: @types)
    @

  save: (e) ->
    e.preventDefault()

    @model.set
      name: @$("input[name=name]").val()
      octicon: @$("input[name=octicon]:checked").val()
      reasons: (input.value for input in @$("input[name=reason]:checked").serializeArray())

    @remove()
    @collection.add @model

  cancel: (e) ->
    e.preventDefault()
    window.history.back()
    @remove()
