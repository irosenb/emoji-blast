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
    var animateLabel: UILabel!
    var collectionController: EmojiViewController!
    
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
        
        setupAnimateLabel()
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
    
    func setupAnimateLabel() {
        animateLabel = UILabel(frame: self.view.frame)
        animateLabel.text = "💥"
        animateLabel.font = UIFont.systemFontOfSize(50)
        animateLabel.sizeToFit()
        animateLabel.alpha = 0
        self.view.addSubview(self.animateLabel)
    }
    
    func blastEmojis(text: String) {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.insertText(text)
        println(proxy.documentContextBeforeInput)
    }
    
    func deleteEmojis() {
//        println("DELETE")
        var proxy = textDocumentProxy as! UITextDocumentProxy
        if (proxy.documentContextBeforeInput != nil) {
            var tokens = proxy.documentContextBeforeInput.componentsSeparatedByString(" ")
            println(tokens.last)
            for emoji in tokens.last as String! {
                proxy.deleteBackward()
            }
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! EmojiCollectionViewCell
        blastEffect(cell)
        blastEmojis(cell.text)
    }
    
    func blastEffect(cell: EmojiCollectionViewCell) {
        var center = self.collectionController.collectionView.convertPoint(cell.center, toView: self.view)
        animateLabel.center = center
        self.view.bringSubviewToFront(animateLabel)
        UIView.animateWithDuration(0.19, animations: { () -> Void in
            self.animateLabel.alpha = 1
            
        }) { (finished) -> Void in
            self.animateLabel.alpha = 0
        }
    }
    
    func addCollection() {
        collectionController = EmojiViewController()
        self.addChildViewController(collectionController)
        collectionController.didMoveToParentViewController(self)
        
        collectionController.view.frame = self.view.frame

        println(collectionController.collectionView.frame)
        collectionController.collectionView.delegate = self
        self.view.addSubview(collectionController.view)
        collectionController.collectionView.frame = collectionController.view.frame
        var constraint = NSLayoutConstraint(item: collectionController.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.nextKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        var sideConstraint = NSLayoutConstraint(item: collectionController.view, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([constraint])
        println(collectionController.view.frame)
        collectionController.view.sizeToFit()
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
