class FbAuth
  constructor: (accessToken) ->
    if accessToken
      @accessToken = accessToken

  authCurrentUser: ->
    user = Meteor.user()
    if user is null
      throw new Meteor.Error 'fb-user-auth', 'No current user'
    else
      @authUser user._id

  authUser: (userId) ->
    user = Meteor.users.findOne {_id: userId}
    accessToken = user?.services?.facebook?.accessToken
    if accessToken
      @accessToken = accessToken
    else
      throw new Meteor.Error 'fb-user-auth', 'User has not authed with Facebook'