describe 'app.Models.Repository', ->
	describe 'decrement', ->
		@repository = new app.Models.Repository(unread_count: 5)
		@repository.decrement()
		expect(@repository.get('unread_count')).toBe(4)