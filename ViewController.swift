//
//  ViewController.swift
//  Remote_Notification_Demo
//
//  Created by fileice on 2019/7/3.
//  Copyright © 2019 fileice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     
     var initialNotification: [String: AnyObject]?
     
     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
          
          //進入畫面調用授權請求
          requestNotificationAuthorization()
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
          //        if let app = initialNotification {
          //            let alert = UIAlertController(title: app["category"] as? String, message: app["alert"] as? String, preferredStyle: .alert)
          //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
          //            self.present(alert, animated: true, completion: nil)
          //        }
          
          if let aps = initialNotification {
               processNotification(aps: aps)
          }
     }
     
     func processNotification(aps: [String : AnyObject]){
          let alert = UIAlertController(title: aps["category"] as? String, message: aps["alert"] as? String, preferredStyle: .alert)
          //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
          
          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
               //可清除通知
               self.clearNotification()
          }))
          self.present(alert, animated: true, completion: nil)
          
     }
     
}


