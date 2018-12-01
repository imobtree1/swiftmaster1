//
//  DemoViewController.swift
//  test
//
//  Created by Imobtree Solutions on 10/31/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import UserNotifications

class DemoViewController: UIViewController {
    @IBOutlet var txtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "test"
        notificationContent.body = "test notification"
        
        let today = Date()
        for j in 0...2 {
            let tomorrow = Calendar.current.date(byAdding: .day, value: j, to: today)
            print(tomorrow!)
            for i in 0...2 {
                var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour, .minute], from: tomorrow!)
                dateComponents.hour = 10
                dateComponents.minute = 53+i
                dateComponents.timeZone = NSTimeZone.default
                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let id:String = String (format: "noti%d%d", i,j)
                let notificationRequest = UNNotificationRequest(identifier: id, content: notificationContent, trigger: notificationTrigger)
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                    if let error = error {
                        print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                    }
                }
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (completion) in
            print(completion)
        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(userDragged(gesture:)))
        txtFld.addGestureRecognizer(gesture)
        txtFld.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func userDragged(gesture: UIPanGestureRecognizer){
        let loc = gesture.location(in: self.view)
        txtFld.center = loc
        
    }
}

