//
//  File.swift
//  YouTube
//
//  Created by Alexander on 19.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImage: String?
    var videoTitle: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var videoDuration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        let capFirstChar = String(key.characters.first!).uppercased()
        let remainder = key.substring(from: key.characters.index(after: key.characters.startIndex))
        
        let selector = NSSelectorFromString("set\(capFirstChar)\(remainder):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        if key == "channel" {
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(channelDictionary)
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}

class Channel: NSObject {
    var channelName: String?
    var profileImage: String?
}
