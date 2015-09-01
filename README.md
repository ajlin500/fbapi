A Meteor SDK for Facebook APIs

Add to settings.json
{
	...

	"facebook": {
		"production" : {
		    "appId": "<PRODUCTION APP ID>",
		    "loginStyle": "popup",
		    "secret": "<PRODUCTION SECRET>"
		},
		"dev" : {
		  "appId": "<TEST APP ID>",
		  "loginStyle": "popup",
		  "secret": "<TEST APP SECRET>"
		}
	},

	...
}
