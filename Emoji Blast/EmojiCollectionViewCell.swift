//
//  EmojiCollectionViewCell.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 6/21/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    var text: String!
    var emojiLabel: UITextView!
    var title: String! {
        didSet {
            emojiLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSizeMake(100, 100)
        emojiLabel = UITextView(frame: self.frame)
        emojiLabel.center = contentView.convertPoint(contentView.center, fromView: contentView.superview)
        emojiLabel.contentMode = UIViewContentMode.ScaleAspectFill
        emojiLabel.font = UIFont.systemFontOfSize(100)
        emojiLabel.backgroundColor = UIColor.clearColor()
        emojiLabel.userInteractionEnabled = false
        emojiLabel.selectable = false
        emojiLabel.frame = self.bounds
        self.contentView.addSubview(emojiLabel)
        self.contentView.backgroundColor = UIColor.blueColor()
    }
    
    func writeEmoji() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
