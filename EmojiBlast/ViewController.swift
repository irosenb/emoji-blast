//
//  ViewController.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 6/17/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let notifications = ["Go back to Settings", "Tap on General", "Tap on Keyboard", "Tap on Keyboards", "Tap Add New Keyboard…", "Tap EmojiBlast", "Tap on Emoji Blast - EmojiBlast", "Allow Full Access", "Tap Allow"]

    @IBAction func goToSettings(sender: AnyObject) {

        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        sendNotifications()
    }
    
    func sendNotifications() {
        for (index, item) in enumerate(notifications) {
            let notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 8.0 * Double(index + 1))
            notification.alertBody = item
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

