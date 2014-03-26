describe 'App.Models.Subject', ->
  describe 'isUnread', ->
    it 'is true without last_read_at', ->
      model = new App.Models.Subject(last_read_at: null)
      expect(model.isUnread()).toBe(true)

    it 'is true created_at is later than last_read_at', ->
      model = new App.Models.Subject(created_at: moment('2013-12-26'), last_read_at: moment('2013-12-25'))
      expect(model.isUnread()).toBe(true)

    it 'is false if created_at is earlier than last_read_at', ->
      model = new App.Models.Subject(created_at: moment('2013-12-24'), last_read_at: moment('2013-12-25'))
      expect(model.isUnread()).toBe(false)
