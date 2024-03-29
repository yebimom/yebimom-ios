//
//  AppDelegate.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/2/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.
//

import UIKit

import GoogleMaps

import Parse
import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Google map
        var keys: NSDictionary?
        if NSBundle.mainBundle().pathForResource("keys", ofType: "plist") != nil {
            let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
            keys = NSDictionary(contentsOfFile: path!)
        }
        let GOOGLE_MAP_API_KEY = keys?["GOOGLE_MAP_API_KEY"] as? String
        let GOOGLE_API_CLIENT_ID = keys?["GOOGLE_API_CLIENT_ID"] as? String

        GMSServices.provideAPIKey(GOOGLE_MAP_API_KEY)
        
        
        // Parse
        let PARSE_APPLICATION_ID = keys?["PARSE_APPLICATION_ID"] as? String
        let PARSE_CLIENT_KEY = keys?["PARSE_CLIENT_KEY"] as? String
        ParseCrashReporting.enable()
        Parse.setApplicationId(PARSE_APPLICATION_ID!,
            clientKey: PARSE_CLIENT_KEY!)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

