Package.describe({
  name: 'andrew:fbapi',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'SDK for facebook\'s graph and marketing apis',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/ajlin500/fbapi',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('http');
  api.use('accounts-facebook');

  api.addFiles('fbauth.coffee', 'server');
  api.addFiles('fbapi.coffee', 'server');

  api.export('FbApi', 'server');
  api.export('FbAuth', 'server');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('sanjo:jasmine@0.15.4');
  api.use('andrew:fbapi');
  api.addFiles('tests/server/fbauth.spec.coffee', 'server');
  api.addFiles('tests/server/fbapi.spec.coffee', 'server');
});
