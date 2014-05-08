describe 'PaginatedCollection', ->
  beforeEach ->
    @collection = new PaginatedCollection()
    @request = $.Deferred()
    @xhr =
      getResponseHeader: jasmine.createSpy('getResponseHeader')

    spyOn($, 'ajax').andReturn(@request)

  describe 'paginate', ->
    context 'when there is a next link', ->
      beforeEach ->
        @xhr.getResponseHeader.andReturn('</url?page=2>; rel="next"')

      it 'fetches next page', ->
        spyOn @collection, 'fetch'
        @collection.paginate({}, {}, @xhr)
        expect(@collection.fetch).toHaveBeenCalledWith({url:'/url?page=2', reset: false, remove:false})

    context 'when there is not a next link', ->
      beforeEach ->
        @xhr.getResponseHeader.andReturn('</url?page=1>; rel="prev"')
        spyOn @collection, 'fetch'

      it 'does not call fetch', ->
        @collection.paginate({}, {}, @xhr)
        expect(@collection.fetch).not.toHaveBeenCalled()

      it 'triggers "paginated" event', ->
        spy = jasmine.createSpy()
        @collection.on 'paginated', spy
        @collection.paginate({}, {}, @xhr)
        expect(spy).toHaveBeenCalled()
