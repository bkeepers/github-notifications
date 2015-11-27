# FIXME: move to App.Views.Filters.Create
class App.Views.FiltersCreate extends Backbone.View
  template: JST['app/templates/filters/create.us']
  className: 'modal'

  octicons: '
    alert beer book briefcase broadcast browser bug calendar check circuit-board clock cloud-download code comment-discussion dashboard database device-camera device-camera-video device-desktop device-mobile diff diff-added diff-ignored diff-modified diff-removed diff-renamed ellipsis eye file-binary file-code file-directory file-media file-pdf file-submodule file-symlink-directory file-symlink-file file-text file-zip flame fold gear gift gist gist-secret git-branch git-commit git-compare git-merge git-pull-request globe graph heart history home horizontal-rule hourglass hubot inbox info issue-closed issue-opened issue-reopened jersey jump-down jump-left jump-right jump-up key keyboard law light-bulb link link-external list-ordered list-unordered location lock mail mail-read mail-reply mark-github markdown megaphone mention microscope milestone mirror mortar-board mute octoface organization package paintcan pencil person pin plug podium pulse puzzle question quote radio-tower repo repo-clone repo-force-push repo-forked repo-pull repo-push rocket rss ruby search server settings sign-in sign-out split squirrel star steps stop sync tag telescope terminal three-bars tools trashcan unfold unmute versions x zap
  '.trim().split(/\s+/)

  # https://developer.github.com/v3/activity/notifications/#notification-reasons
  reasons:
    subscribed:
      octicon:      'repo'
      description:  'watching the repository'
    manual:
      octicon:      'eye'
      description:  'you manually subscribed'
    author:
      octicon:      'pencil'
      description:  'created by you'
    comment:
      octicon:      'comment'
      description:  'you commented'
    mention:
      octicon:      'mention'
      description:  'you were mentioned'
    team_mention:
      octicon:      'jersey'
      description:  'a team was mentioned'
    state_change:
      octicon:      'issue-closed'
      description:  'you changed the state'
    assign:
      octicon:      'checklist'
      description:  'assigned to you'

  events:
    'submit form': 'save'
    'click .close,.overlay': 'cancel'

  initialize: ->
    @listenTo @model, "invalid", @invalid

  render: ->
    @$el.html @template(model: @model.toJSON(), octicons: @octicons, reasons: @reasons, types: @types)
    @

  save: (e) ->
    e.preventDefault()

    @model.set
      name: @$("input[name=name]").val()
      octicon: @$("input[name=octicon]:checked").val()
      reasons: (input.value for input in @$("input[name=reason]:checked").serializeArray())

    if @model.isValid()
      @remove()
      @collection.add @model

  invalid: (_, errors) ->
    @$(".invalid").removeClass("invalid")
    @$("input[name=#{field}]").addClass("invalid") for field in errors
    @$(".invalid:first").focus()

  cancel: (e) ->
    e.preventDefault()
    window.history.back()
    @remove()
