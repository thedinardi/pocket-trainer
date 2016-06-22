//
//  AppDelegate.swift
//  Quiz App
//
//  Created by AE Tower on 11/9/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import GameAnalytics
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self, GameAnalytics.self])
        
        UINavigationBar.appearance().tintColor = UIColor.blueColor()
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "PocketTrainer4545"
            $0.clientKey = ""
            //$0.server = "http://localhost:1337/parse"
            //$0.server = "http://192.168.0.102:1337/parse"
            $0.server = "http://parseserver-836sq-env.us-east-1.elasticbeanstalk.com/parse"
        }
        
        PFCourse.registerSubclass()
        PFLesson.registerSubclass()
        PFQuestion.registerSubclass()
        Parse.initializeWithConfiguration(configuration)
        
        return true
    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
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

    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        var orientation = UIInterfaceOrientationMask.Portrait
        
        if let presentedController = window?.rootViewController?.presentedViewController {
            if presentedController.isKindOfClass(NSClassFromString("AVFullScreenViewController").self!) {
                orientation = .Landscape
                //orientation = .AllButUpsideDown
            } else if let navController = presentedController as? UINavigationController {
                if navController.topViewController!.isKindOfClass(NSClassFromString("AVFullScreenViewController").self!) {
                    orientation = .Landscape
                    //orientation = .AllButUpsideDown
                }
            }
        }
        
        return orientation
    }

}

