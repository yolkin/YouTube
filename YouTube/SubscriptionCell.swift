//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Alexander on 27.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func getVideos() {
        Maintenance.sharedInstance.getSubscriptionVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
