//
//  EmojiLoader.swift
//  EmojiBlast
//
//  Created by Isaac Rosenberg on 6/18/15.
//  Copyright (c) 2015 irosenb. All rights reserved.
//

import Foundation
import Parse

class Emoji {
    class func load() -> [PFObject] {
        var query: PFQuery = PFQuery(className: "Pack")
        return query.findObjects(nil) as! [PFObject]
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if (error == nil) {
//                println(objects)
////                return objects
//            }
//        }
    }
}