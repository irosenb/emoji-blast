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
        emojiLabel = UITextView(frame: self.bounds)
        emojiLabel.font = UIFont.systemFontOfSize(100)
        emojiLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(emojiLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
