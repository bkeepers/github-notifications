describe 'App.Collections.Repositories', ->
  context 'findByName', ->
    beforeEach ->
      @collection = new App.Collections.Repositories([])

    it 'finds model by name', ->
      model = new App.Models.Repository(full_name: 'foo/bar')
      @collection.add(model)
      expect(@collection.findByName('foo/bar')).toEqual(model)
