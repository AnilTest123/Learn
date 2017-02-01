//
//  KeluConstants.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

//Error Status code
static NSInteger const kUnauthorizedRequest = 401;
static NSInteger const kUnknownBaseURLError = 1;
static NSInteger const kUnsupportedURLError = -1002;
#define kKeychainHasLoggedIn @"HasLoggedIn"
#define kKeychainSelectedLanguageKey @"SelectedLanguageKey"
#define kKeychainSelectedLanguageName @"SelectedLanguageName"
#define kKeychainSelectedThemeTag @"SelectedThemeTag"
#define kKeyChainDocumentDirectoryPath @"Application Document Directory"

static NSString *keluHeaderViewUpdateNotification = @"Reload Header View";
static NSString *keluThemeChangeNotification = @"Theme Changed";
