describe 'App.Models.Filter', ->
  describe 'id', ->
    it 'is set from name', ->
      model = new App.Models.Filter(name: "FooBar")
      expect(model.id).toEqual("foobar")

  describe 'validate', ->
    beforeEach ->
      @model = new App.Models.Filter
        name: 'Test'
        octicon: 'test'

    it 'is valid with all attributes', ->
      expect(@model.validate()).toBe(undefined)

    it 'is invalid without a name', ->
      @model.set name: null
      expect(@model.validate()).toEqual(['name'])

    it 'is invalid with a blank name', ->
      @model.set name: ""
      expect(@model.validate()).toEqual(['name'])

    it 'is invalid without an octicon', ->
      @model.set octicon: null
      expect(@model.validate()).toEqual(['octicon'])
