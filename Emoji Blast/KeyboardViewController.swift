//
//  KeyboardViewController.swift
//  Emoji Blast
//
//  Created by Isaac Rosenberg on 6/17/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit
import Parse
import Bolts

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var emojiButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("L1V2i5LD9uTe8gEi0uo0Ty7ZkEISbZDCYOvLOXjn",
            clientKey: "flQwsRmH6TfEjSNjz14TK1JkPaDEOPs2pmNbZv3T")
        
//        loadEmojis()
        
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    func blastEmojis(sender: AnyObject) {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.insertText("😂😁😄😊😊😄😃😝😃😂")
    }
    
    func addCollection() {
        
    }
    
    func loadEmojis() {
        emojiButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        emojiButton.setTitle("😃", forState: UIControlState.Normal)
        emojiButton.titleLabel?.font = UIFont.systemFontOfSize(100.0)
        emojiButton.sizeToFit()
        emojiButton.addTarget(self, action: "blastEmojis:", forControlEvents: UIControlEvents.TouchUpInside)
        self.inputView.addSubview(emojiButton)
        
        
        var sadButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        sadButton.setTitle("😩", forState: UIControlState.Normal)
        sadButton.frame = CGRectMake(100, 0, sadButton.frame.width, sadButton.frame.height)
        sadButton.titleLabel?.font = UIFont.systemFontOfSize(100.0)
        sadButton.sizeToFit()
        sadButton.addTarget(self, action: "blastEmojis:", forControlEvents: UIControlEvents.TouchUpInside)
        self.inputView.addSubview(sadButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
