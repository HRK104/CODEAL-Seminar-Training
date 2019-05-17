//
//  main.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/12.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyUIApplication.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        return UIApplicationMain(argc, argv, NSStringFromClass([MyUIApplication class]), NSStringFromClass([AppDelegate class]));
    }
}
