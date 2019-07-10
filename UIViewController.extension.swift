//
//  UIViewController.extension.swift
//  Remote_Notification_Demo
//
//  Created by fileice on 2019/7/3.
//  Copyright © 2019 fileice. All rights reserved.
//

import UIKit
import UserNotifications

extension UIViewController{
    /*確保用戶撤銷授權時看可以恢復用戶通知設置 並且用戶可再次激活權限 檢查權限後
      調用 registerForRemoteNotifications 啟用遠程通知*/
    func getNotificationSettings(){
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            //用戶通知設定
            guard setting.authorizationStatus == .authorized else {return}
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    /*請求用戶發送通知權限。在option 選擇通知類型。將出現一個確認對話視窗。允許用戶啟用或禁用*/
    func requestNotificationAuthorization(){
        //請求權限
        UNUserNotificationCenter.current()
            .requestAuthorization(
            options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                //print("推播通知: (granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
        
    }
     
     //本地推播
     func userNotification(message: String, title: String, count: Int){
          //creating the notification content
          let content = UNMutableNotificationContent()
          content.title = title
          content.subtitle = ""
          content.body = message
          content.badge = count as NSNumber
          //getting the notification trigger
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
          //getting the notification request
          let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
          //adding the notification to notification center
          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
     }
     
     func clearNotification(){
          UIApplication.shared.applicationIconBadgeNumber = 0
          let notifications =  UNUserNotificationCenter.current()
          notifications.removeAllPendingNotificationRequests()
          notifications.removeAllDeliveredNotifications()
          
     }
    
}
