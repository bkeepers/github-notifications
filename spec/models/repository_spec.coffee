describe 'App.Models.Repository', ->
  describe 'decrement', ->
    it 'decreases count', ->
      @repository = new App.Models.Repository(unread_count: 5)
      @repository.decrement()
      expect(@repository.get('unread_count')).toBe(4)

    it 'does not go below 0', ->
      @repository = new App.Models.Repository(unread_count: 0)
      @repository.decrement()
      expect(@repository.get('unread_count')).toBe(0)
