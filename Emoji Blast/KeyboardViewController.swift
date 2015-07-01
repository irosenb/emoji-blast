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

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate {

    @IBOutlet var nextKeyboardButton: UIButton!
    var emojiButton: UIButton!
    var deleteButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        addCollection()
        self.view.bringSubviewToFront(nextKeyboardButton)
        self.view.bringSubviewToFront(deleteButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Parse.
        Parse.setApplicationId("L1V2i5LD9uTe8gEi0uo0Ty7ZkEISbZDCYOvLOXjn",
            clientKey: "flQwsRmH6TfEjSNjz14TK1JkPaDEOPs2pmNbZv3T")
        
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)

        self.view.addSubview(self.nextKeyboardButton)

        deleteButton = UIButton.buttonWithType(.System) as! UIButton
        deleteButton.setTitle("Delete", forState: .Normal)
        deleteButton.sizeToFit()
        deleteButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        deleteButton.addTarget(self, action: "deleteEmojis", forControlEvents: .TouchUpInside)
        self.view.addSubview(deleteButton)
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        var deleteKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.deleteButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        var deleteButtonRightSideConstraint = NSLayoutConstraint(item: self.deleteButton, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0)

        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint, deleteButtonRightSideConstraint, deleteKeyboardButtonBottomConstraint])

    }
    
    func blastEmojis(text: String) {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.insertText(text)
        println(proxy.documentContextBeforeInput)
    }
    
    func deleteEmojis() {
        println("DELETE")
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! EmojiCollectionViewCell
        blastEmojis(cell.text)
    }
    
    func addCollection() {
        var collectionController = EmojiViewController()
        self.addChildViewController(collectionController)
        collectionController.didMoveToParentViewController(self)
        
        collectionController.view.frame = self.view.frame
        println(collectionController.collectionView.frame)
        collectionController.collectionView.delegate = self
        
        var constraint = NSLayoutConstraint(item: collectionController.collectionView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.nextKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 1.0)
//        collectionController.collectionView.addConstraint(constraint)
        
        self.view.addSubview(collectionController.view)
        collectionController.collectionView.sizeToFit()
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
