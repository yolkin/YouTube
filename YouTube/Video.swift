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
    var numberOfViews: String?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var channelName: String?
    var profileImage: String?
}
