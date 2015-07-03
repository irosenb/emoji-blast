//
//  ViewController.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 6/17/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func goToSettings(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)



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

