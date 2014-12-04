describe 'View', ->
  beforeEach ->
    @view = new View
    @subview = @view.subview(new View)

  describe 'remove', ->
    it 'removes subviews', ->
      spyOn @subview, 'remove'
      @view.remove()
      expect(@subview.remove).toHaveBeenCalled()

  describe 'hide', ->
    it 'hides subviews', ->
      spyOn @subview, 'hide'
      @view.hide()
      expect(@subview.hide).toHaveBeenCalled()

  describe 'show', ->
    it 'shows subviews', ->
      spyOn @subview, 'show'
      @view.show()
      expect(@subview.show).toHaveBeenCalled()
