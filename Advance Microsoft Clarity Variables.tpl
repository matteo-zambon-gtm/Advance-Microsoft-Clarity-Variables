___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_T5PHP",
  "version": 1,
  "displayName": "Advance Microsoft Clarity Variables",
  "description": "Retrieves the Microsoft Clarity variables: playback URL recordings for that user\u0027s session, User ID or Session ID\n\nThis is a branch version of Microsoft Clarity Playback URL by Jude Nwachukwu",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "clarityProjectID",
    "displayName": "Microsoft Clarity Project ID",
    "simpleValueType": true,
    "valueHint": "e.g., abc123xyz",
    "help": "Enter your Microsoft Clarity project ID in this field.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SELECT",
    "name": "clarityOutput",
    "displayName": "Output",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "playbackurl",
        "displayValue": "Playback URL"
      },
      {
        "value": "userid",
        "displayValue": "User ID"
      },
      {
        "value": "sessionid",
        "displayValue": "Session ID"
      }
    ],
    "simpleValueType": true,
    "help": "Choose the output: Playback URL (https://clarity.microsoft.com/player/8tvjyax1lp/1025882/1amq0nx) or User ID (1025882) or Session ID (1amq0nx)"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getCookieValues = require('getCookieValues');
const decode = require('decodeUri');

// Get the project ID from the template field
const clarityProjectID = data.clarityProjectID;
const clarityOutput = data.clarityOutput;

// Read and decode cookie values
const clskCookieValues = getCookieValues('_clsk', true);
const clckCookieValues = getCookieValues('_clck', true);

if (!clskCookieValues || !clskCookieValues.length || 
    !clckCookieValues || !clckCookieValues.length) {
  return undefined; // Return undefined if cookies are missing
}

// Decode and split cookie values
let clskValue = decode(clskCookieValues[0]);
let clckValue = decode(clckCookieValues[0]);

if (!clskValue || !clckValue) {
  return undefined; // Return undefined if decoding fails
}

clskValue = clskValue.split('|')[0];
clckValue = clckValue.split('|')[0];

if (!clskValue || !clckValue) {
  return undefined; // Return undefined if splitting fails
}

// Use a switch statement to return the correct value based on clarityOutput
switch (clarityOutput) {
  case 'playbackurl':
    return 'https://clarity.microsoft.com/player/' + clarityProjectID + '/' + clckValue + '/' + clskValue;
  case 'userid':
    return clckValue;
  case 'sessionid':
    return clskValue;
  default:
    return undefined;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_clsk"
              },
              {
                "type": 1,
                "string": "_clck"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 1/23/2025, 2:45:34 PM


