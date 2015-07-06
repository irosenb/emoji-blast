//
//  AddEmojiViewController.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 7/5/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit
import Parse

class AddEmojiViewController: UIViewController {

    @IBOutlet weak var emojiTextView: UITextView!
    @IBOutlet weak var titleView: UITextField!
    
    @IBOutlet weak var submittButton: UIButton!
    
    @IBAction func submitEmojis(sender: AnyObject) {
        var title = titleView.text
        var emojis = emojiTextView.text
        
        var pack = PFObject(className: "Pack")
        pack["title"] = title
        pack["text"] = emojis
        pack.saveInBackgroundWithBlock { (saved, error) -> Void in
            if saved {
                println("Saved")
            }
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
