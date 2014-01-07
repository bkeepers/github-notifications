describe 'app.Models.Comment', ->
  describe 'isUnread', ->
    beforeEach ->
      @collection = new app.Collections.Comments([], last_read_at: moment('2013-12-25'))

    it 'is true if no collection', ->
      comment = new app.Models.Comment()
      expect(comment.isUnread()).toBe(true)

    it 'is true if collection does not have last_read_at', ->
      @collection.last_read_at = null
      comment = new app.Models.Comment({}, collection: @collection)
      expect(comment.isUnread()).toBe(true)

    it 'is true created_at is later than last_read_at on collection', ->
      comment = new app.Models.Comment({created_at: moment('2013-12-26')}, collection: @collection)
      expect(comment.isUnread()).toBe(true)

    it 'is false if created_at is earlier than last_read_at on collection', ->
      comment = new app.Models.Comment({created_at: moment('2013-12-24')}, collection: @collection)
      expect(comment.isUnread()).toBe(false)
