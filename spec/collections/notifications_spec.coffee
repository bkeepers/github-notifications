describe 'App.Collections.Notifications', ->
  context 'with a filter', ->
    beforeEach ->
      filter = (model) -> model.get('bonafide')
      @collection = new App.Collections.Notifications([], filter: filter)

    it 'adds models that satisfy the filter', ->
      @collection.add new Backbone.Model(name: 'Vernon T. Waldrip', bonafide: true)
      expect(@collection.size()).toBe(1)

    it 'ignores models that do not satisfy the filter', ->
      @collection.add new Backbone.Model(name: 'Ulysses Everett McGill', bonafide: false)
      expect(@collection.size()).toBe(0)
