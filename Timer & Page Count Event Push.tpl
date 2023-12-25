___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Timer \u0026 Page Count Event Push",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "When the specified time and page count are completed, it sends an event to the dataLayer",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "PageCount",
    "displayName": "Page Count",
    "simpleValueType": true,
    "defaultValue": 1,
    "help": "second duration  example:5"
  },
  {
    "type": "TEXT",
    "name": "Duration",
    "displayName": "Duration",
    "simpleValueType": true,
    "help": "second duration  example:180",
    "defaultValue": 30
  },
  {
    "type": "RADIO",
    "name": "EventRepeated",
    "radioItems": [
      {
        "value": true,
        "displayValue": "Unlimited",
        "help": "the condition works once every time it is fulfilled"
      },
      {
        "value": false,
        "displayValue": "one per session",
        "help": "Runs once per session"
      }
    ],
    "simpleValueType": true,
    "displayName": "Tag firing options"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getTimestamp = require('getTimestamp');
const makeInteger = require('makeInteger');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const callLater = require('callLater');
const createQueue = require('createQueue');
const copyFromWindow = require('copyFromWindow');

var everyTime = data.EventRepeated;

const pageCountCookieName = '_ugpc';
const lastInteractionTimeCookieName = '_ugulit';

let currentTime = getTimestamp();

let pageCount = makeInteger(getCookieValues(pageCountCookieName)) || 0;
let lastInteractionTime = makeInteger(getCookieValues(lastInteractionTimeCookieName));

if (!lastInteractionTime) {
    lastInteractionTime = currentTime;
    setCookie(lastInteractionTimeCookieName, lastInteractionTime.toString());
}

pageCount += 1;
setCookie(pageCountCookieName, pageCount.toString());

function startTimer() {
    callLater(checkConditions, 2000);
}

function checkConditions() {
    currentTime = getTimestamp();
    const timeSpent = currentTime - lastInteractionTime;

    if (timeSpent >= data.Duration * 1000 && pageCount >= data.PageCount ) {
        pushData();
        if (everyTime) {
            setCookie(pageCountCookieName, "0");
            setCookie(lastInteractionTimeCookieName, currentTime.toString());
        }

        if (everyTime == false) {
          
            setCookie('_ughc', "1");
            return;
        }
    } else {
        startTimer();
    }
}

if (everyTime == true || !makeInteger(getCookieValues('_ughc'))) {
    checkConditions();
}

    function pushData() {
     
        var dataLayer = copyFromWindow('dataLayer') || [];
        dataLayer.push({ event: 'task_completion_event' });
    
  }
data.gtmOnSuccess();


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
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_ugpc"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_ugulit"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_ughc"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
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
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
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

Created on 12/21/2023, 12:12:29 PM


