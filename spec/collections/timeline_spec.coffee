describe 'app.Collections.Timeline', ->
  describe 'comparator', ->
    it 'sorts by created_at', ->
      @collection = new app.Collections.Timeline
      @collection.add new app.Models.Comment(created_at: '2014-02-13')
      @collection.add new app.Models.Comment(created_at: '2014-02-12')
      @collection.add new app.Models.Comment(created_at: '2014-02-15')

      expect(@collection.first().get('created_at')).toEqual('2014-02-12')
      expect(@collection.last().get('created_at')).toEqual('2014-02-15')

  describe 'observe', ->
    beforeEach ->
      @timeline = new app.Collections.Timeline
      @other = new Backbone.Collection()

      @timeline.observe @other

    it 'syncs adds and removes', ->
      model = new Backbone.Model
      @other.add model
      expect(@timeline.size()).toBe(1)
      expect(@timeline.first()).toEqual(model)

      @other.remove model
      expect(@timeline.size()).toBe(0)
