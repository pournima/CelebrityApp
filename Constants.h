//
//  Constants.h
//  CheckinLibrary
//
//  Created by nachi on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef CheckinLibrary_Constants_h
#define CheckinLibrary_Constants_h

#define ALRT_SRCH_ENTER_TEXT @"Please enter text to search"
#define SEARCH_MSG @"Searching.. Please wait"
#define ALRT_SRCH_ENTER_TEXT_HEADER @"Search text missing"
#define FOOTER_MSG @"POWERED BY CHECK-IN FOR GOOD"
#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320
#define CHILD_CONTROLLER_TAG 23
#define ALRT_NO_INTERNET_MSG @"No Internet Connectivity"
#define ABOUT_US_HEADING @"About USA Football"
#define ABOUT_US_UP_CONTENT @"Football\'s national governing body, leads the game\'s developement, inspires participation, and ensures a positive experience for all youth, high school, and other amature players."
#define ABOUT_US_DOWN_CONTENT @"Endowed by the NFL and NFLPA in 2002, USA Football is the official youth football development partner of the NFL, its 32 teams and the NFL Players Association ans manages U.S. national teams for international competiton. USA Football is an independent 501-c-3 non-profit organization that leads the developement of the game through educational programs and innovative resources. USA Football also annually awards $1 million in equipment grants and subsidizes league volunteer background checks."
#define LABEL_BUSINESS @"Text will be Support us by checking in at participating businesses.  Every time you check-in a donation is made."


//Navigation bar titles
#define NAV_ALLCAUSES @"Causes to Support"
#define NAV_MYCAUSES @"My Causes"
#define NAV_CHECKIN @"Check-in"
#define NAV_HOWITWORKS @"How it Works"
#define NAV_MAP @"Map"
#define NAV_CAUSES @"Causes"
#define NAV_PRIVACY @"Privacy Policy"
#define NAV_SEARCH_BUS @"Businesses"
#define NAV_SETTINGS @"Settings"
#define NAV_SHARING_SETTINGS @"Sharing Settings"
#define NAV_SNAP_VER_PAGE @"Snap Verification"
#define NAV_TERMS_OF_USE @"Terms of Service"
#define NAV_YOURGOOD @"My Good"
#define NAV_CONTACT_SUPPORT @"Support"
#define NAV_SHARING_SETUP @"Sharing Setup"
#define NAV_CONTACT @"Contact"
#define NAV_ABOUT_US @"About"
#define NAV_HEALTH_SAFETY @"Health & Safety"
#define NAV_RULES @"Rules"

//Third party application ID's
#define FACEBOOK_ID @"396355100423309"
#define GOOGLE_ANALYTICS_ID @"UA-31354915-1"
#define FACEBOOK @"Facebook"
#define TWITTER @"Twitter"

//Static tableView Row items

#define SETTINGS_TABLE_SHARING @"Sharing Settings"
#define SETTINGS_TABLE_HOWITWORKS @"How Check-in for Good Works"
#define SETTINGS_TABLE_PRIVACY @"Privacy Policy"
#define SETTINGS_TABLE_TERMSOFUSE @"Terms Of Service"
#define SETTINGS_CONTACT_US @"Support & Contact Us"
#define SETTINGS_YOUR_GOOD @"My Good"
#define SUPPORTING @"Supporting"
#define RAISED_MSG @"You've raised"
#define FACEBOOK @"Facebook"
#define TWITTER @"Twitter"

//Twitter Keys
#define TW_X_AUTH_MODE_KEY                  @"x_auth_mode"
#define TW_X_AUTH_MODE_REVERSE_AUTH         @"reverse_auth"
#define TW_X_AUTH_MODE_CLIENT_AUTH          @"client_auth"
#define TW_X_AUTH_REVERSE_PARMS             @"x_reverse_auth_parameters"
#define TW_X_AUTH_REVERSE_TARGET            @"x_reverse_auth_target"
#define TW_X_AUTH_USERNAME                  @"x_auth_username"
#define TW_X_AUTH_PASSWORD                  @"x_auth_password"
#define TW_SCREEN_NAME                      @"screen_name"
#define TW_USER_ID                          @"user_id"
#define TW_OAUTH_TOKEN                      @"oauth_token"
#define TW_OAUTH_SECRET                     @"oauth_token_secret" 
#define TW_OAUTH_URL_REQUEST_TOKEN          @"https://api.twitter.com/oauth/request_token"
#define TW_OAUTH_URL_AUTH_TOKEN             @"https://api.twitter.com/oauth/access_token"
#define POP_ALERT(_W,_X) [[[UIAlertView alloc] initWithTitle:_W message:_X delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]
#define CONSUMER_SECRET @"B5wICUQYT1PWMVXH7QBGkmPV1bn4Jcd5M7M9LXWvI0" //@"gI8R1gt27ryMJZLSHl5CLi2SKncJyxkqlKCSzPyw8"
#define CONSUMER_KEY @"MX6TTrUJix70gRkCaJbh3w" // @"EevD9tRO1GB3eryMq183g"

//B5wICUQYT1PWMVXH7QBGkmPV1bn4Jcd5M7M9LXWvI0
//MX6TTrUJix70gRkCaJbh3w

//Login API Keys
#define SIGN_UP_KEY @"signUpUrl_key"
#define SIGN_IN_KEY @"signInUrl_key"
#define FORGOT_PWD_KEY @"forgotPwdUrl_key"
#define APP_ID_KEY @"app_id"
#define FIRST_NAME @"first_name"
#define LAST_NAME @"last_name"
#define EMAIL @"email"
#define PASSWORD @"password"
#define SIGN_UP_EMAIL @"signupEmail"

//JSON Key
#define API_KEY @"api_key"
#define MESSAGE @"message"
#define LOGIN @"login"
#define CHECKIN_COUNT @"checkin_count"
#define CHECKIN_AMOUNT @"checkin_amount"
#define MOBILE_USER @"mobile_user"
#define ORGNISATION @"organization"
#define ORGS @"orgs"
#define ORG_ID @"id"
#define ORG_NAME @"name"
#define SUPPORTED_CAUSES @"supported"
#define SUPPORTED_COUNT @"support_count"
#define DISTANCE @"distance"

//Drag and refresh messages
#define REFRESH_RELEASE_MSG @"Release to refresh..."
#define REFRESH_PULL_MSG @"Pull down to refresh"
#define REFRESH_BUS_LOADING_MSG @"Finding great offers near you"

//----------- Alert box messages-------------//

#define ALRT_ENABLE_LOCATION_MSG @"Location Services are not enabled. Please enable from Settings"
#define ALRT_ENABLE_LOCATION_HEADER_MSG @"Location Services"
#define ALRT_SRCH_ENTER_TEXT @"Please enter text to search"
#define ALRT_SRCH_ENTER_TEXT_HEADER @"Search text missing"
#define ALRT_INVALID_DISTANCE_MSG @"Your GPS shows you are too far from the business location to check-in."
#define ALRT_INVALID_TIME_MSG @"We're sorry.  You aren't allowed to check in at this location at this time of day."
#define ALRT_INVALID_DAY_MSG @"Checkins are not allowed today"
#define ALRT_CHECKIN_ONLY_ONCE_MSG @"You can checkin only once per day for an offer."
#define ALRT_SETUP_SOCIAL_SETTINGS_MSG @"Set-up Facebook and/or Twitter to share your Check-ins."
#define ALRT_NO_INTERNET_MSG @"No Internet Connectivity"
#define ALRT_LOCATION_ERROR @"We cannot find your current location,please check after some time"

//------ Loading messages in Progress dialog------------//

#define BUSINESS_LOADING_MSG @"Finding great offers near you."
#define LOGIN_MSG @"Signing in... Please wait."
#define CAUSES_MSG @"Finding causes near your area."
#define CHECKIN_MSG @"Checking-in"
#define SEARCH_MSG @"Searching.. Please wait"
#define SIGNUP_MSG @"Signing up.. Please wait"
#define FORGOT_PWD @"Resetting your password.. please wait"

//------ Image Names --------//
#define BACKGROUND_IMG @"Headsup_greybg_44.png"

//Flags
#define MY_CAUSES 1
#define ALL_CAUSES 0
#define FACEBOOK_ROW_CLICK @"facebook_row_click"
#define TWITTER_ROW_CLICK @"twitter_row_click"

#endif
