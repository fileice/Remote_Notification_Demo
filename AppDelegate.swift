//
//  AppDelegate.swift
//  Remote_Notification_Demo
//
//  Created by fileice on 2019/7/3.
//  Copyright © 2019 fileice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     
     var window: UIWindow?
     
     
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          // Override point for customization after application launch.
          
          //檢查遠程通知
          // Check remote notification
          let notificationOption = launchOptions?[.remoteNotification]
          if let notification = notificationOption as? [String: AnyObject],
               let aps = notification["aps"] as? [String: AnyObject] {
               // Process remote notification in the view
               let main = window?.rootViewController as! ViewController
               main.initialNotification = aps
          }
          
          return true
     }
     
     func applicationWillResignActive(_ application: UIApplication) {
          // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
          // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
     }
     
     func applicationDidEnterBackground(_ application: UIApplication) {
          // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
          // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     }
     
     func applicationWillEnterForeground(_ application: UIApplication) {
          // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     }
     
     func applicationDidBecomeActive(_ application: UIApplication) {
          // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     }
     
     func applicationWillTerminate(_ application: UIApplication) {
          // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     }
     
     
}

extension AppDelegate{
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          let tokenParts = deviceToken.map
          { data in String(format: "%02.2hhx", data) }
          let token = tokenParts.joined()
          print("My Device Token: \(token)")
     }
     
     func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
          print("註冊錯誤\(error)")
     }
     
     //app 運行時 可接收通知
     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          guard let aps = userInfo["aps"] as? [String: AnyObject] else {
               completionHandler(.failed)
               return
          }
          
          let main =  window?.rootViewController as! ViewController
          main.processNotification(aps: aps)
     }
}




