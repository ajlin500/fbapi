describe 'fbapi', ->
  beforeEach -> MeteorStubs.install()
  afterEach -> MeteorStubs.uninstall()

  describe 'init', ->
    auth = null
    fbApi = null

    beforeEach ->
      auth = 
        accessToken: '1234'
      fbApi = new FbApi(auth)

    it 'should set the @auth property', ->
      expect(fbApi.auth).toBe auth

  # describe 'get', ->
  #   url = null
  #   api = null

  #   beforeEach ->
  #     api = 'https://test.com'
  #     url = '/me'

  #     fbApi = new FbApi()
  #     fbApi.api = api
  #     fbApi.get url

  #   fit 'should make a GET request to the full api url', ->
  #     expectedUrl = api + url
  #     expect(HTTP.get).toHaveBeenCalledWith expectedUrl