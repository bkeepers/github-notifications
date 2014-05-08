describe 'App.Models.Comment', ->
  describe 'isUnread', ->
    beforeEach ->
      @subject = new App.Models.Subject(last_read_at: moment('2013-12-25'))
      @collection = new App.Collections.Comments([], subject: @subject)

    it 'is true if no collection', ->
      comment = new App.Models.Comment()
      expect(comment.isUnread()).toBe(true)

    it 'is true if subject does not have last_read_at', ->
      @subject.last_read_at = null
      comment = new App.Models.Comment({}, collection: @collection)
      expect(comment.isUnread()).toBe(true)

    it 'is true created_at is later than last_read_at on subject', ->
      comment = new App.Models.Comment({created_at: moment('2013-12-26')}, collection: @collection)
      expect(comment.isUnread()).toBe(true)

    it 'is false if created_at is earlier than last_read_at on subject', ->
      comment = new App.Models.Comment({created_at: moment('2013-12-24')}, collection: @collection)
      expect(comment.isUnread()).toBe(false)
