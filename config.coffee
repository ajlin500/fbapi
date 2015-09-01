if Meteor.isServer
  env = undefined
  if process.env.NODE_ENV == 'production'
    env = 'production'
  else
    env = 'dev'
  if Meteor.settings
    ServiceConfiguration.configurations.upsert
      service: 'facebook'
    ,
      $set: Meteor.settings.facebook[env]