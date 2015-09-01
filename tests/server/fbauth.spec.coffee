describe 'fbauth', ->
  beforeEach -> MeteorStubs.install()
  afterEach -> MeteorStubs.uninstall()

  describe 'authCurrentUser', ->

    describe 'user logged in', ->
      fbAuth = null
      user = null

      beforeEach ->
        user = 
          _id: 1234
        fbAuth = new FbAuth()
        spyOn fbAuth, 'authUser'

        spyOn(Meteor, 'user').and.returnValue user

        fbAuth.authCurrentUser()

      it 'should call auth user with user id', ->
        expect(fbAuth.authUser).toHaveBeenCalledWith user._id

    describe 'no user logged in', ->
      fbAuth = null

      beforeEach ->
        spyOn(Meteor, 'user').and.returnValue null
        fbAuth = new FbAuth()

      it 'should throw and error', ->
        expect( () ->
            fbAuth.authCurrentUser()
        ).toThrow()

  describe 'authUser', ->

    describe 'user exists', ->

      describe 'user has access token', ->
        accessToken = null
        fbAuth = null

        beforeEach ->
          accessToken = '1234'
          user =
            services:
              facebook:
                accessToken: accessToken
          spyOn(Meteor.users, 'findOne').and.returnValue user

          fbAuth = new FbAuth()
          fbAuth.authUser '123'

        it 'should set the access token to the fbAuth object', ->
          expect(fbAuth.accessToken).toEqual accessToken

      describe 'user doesn\'t have an accessToken', ->
        fbAuth = null

        beforeEach ->
          user = {}
          spyOn(Meteor.users, 'findOne').and.returnValue user
          fbAuth = new FbAuth()

        it 'should throw a meteor error', ->
          expect( () ->
            fbAuth.authUser('123')
          ).toThrow()

    describe 'user doesn\'t exist', ->
