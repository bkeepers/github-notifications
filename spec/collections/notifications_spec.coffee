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

    it 'marks each notification individually as read', ->
      model = new Backbone.Model(name: 'Iliad', bonafide: true)
      model.read = jasmine.createSpy('read')
      @collection.add(model)
      @collection.read()
      expect(model.read).toHaveBeenCalled()

  describe 'comparator', ->
    it 'orders by updated at', ->
      @collection = new App.Collections.Notifications([])
      @collection.add([
        new Backbone.Model({id: 1, updated_at: "2014-09-14"})
        new Backbone.Model({id: 2, updated_at: "2014-09-15"})
        new Backbone.Model({id: 3, updated_at: "2014-09-13"})
      ])

      expect(@collection.at(0).id).toBe(2)
      expect(@collection.at(1).id).toBe(1)
      expect(@collection.at(2).id).toBe(3)
