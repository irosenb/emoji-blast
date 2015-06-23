//
//  EmojiViewController.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 6/20/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit
import Parse

class EmojiViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var emojis: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojis = Emoji.load()
        println(emojis)
        
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.minimumLineSpacing = 10000
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.userInteractionEnabled = true
//        self.view = collectionView
        self.view.addSubview(collectionView)
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EmojiCollectionViewCell
        var item = emojis[indexPath.item]
        cell.title = item["title"] as! String
        cell.text = item["text"] as! String
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 40
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // This isn't working. Figure out why 😒
        println("HI")
        KeyboardViewController().blastEmojis(emojis[indexPath.item]["text"] as! String)
    }
    
    func writeEmoji(recog: UITapGestureRecognizer) {
//        let point = recog.locationInView(self.view)
//        KeyboardViewController().blastEmojis(emojis[indexPath.item]["text"] as! String)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
