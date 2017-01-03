//
//  Trending.swift
//  YouTube
//
//  Created by Alexander on 27.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func getVideos() {
        Maintenance.sharedInstance.getTrendingVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
