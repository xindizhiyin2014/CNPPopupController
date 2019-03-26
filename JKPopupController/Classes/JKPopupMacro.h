//
//  JKPopupMacro.h
//  JKPopupController
//
//  Created by JackLee on 2019/3/26.
//

#ifndef JKPopupMacro_h
#define JKPopupMacro_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define IS_IPHONE_X (kStatusBarHeight >= 44.0f)
#define kNavigationBarNormalHeight (44)
#define kNavigationBarHeight (kNavigationBarNormalHeight + kStatusBarHeight)
#define kBottomSafeAreaHeight (IS_IPHONE_X?34:0)
#define kTabBarNormalHeight (49)
#define kTabBarHeight (kTabBarNormalHeight+kBottomSafeAreaHeight)
#define kScale (SCREEN_WIDTH/360.0)
#define kIPadScale (IS_IPAD?1:kScale)

#endif /* JKPopupMacro_h */
