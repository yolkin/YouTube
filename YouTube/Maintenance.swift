//
//  Maintenance.swift
//  YouTube
//
//  Created by Alexander on 22.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class Maintenance: NSObject {

    static let sharedInstance = Maintenance()
    
    func getVideos(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://www.dropbox.com/s/orjuv0w2ycsqc61/home.json?dl=1")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.videoTitle = dictionary["title"] as? String
                    video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.channelName = channelDictionary["name"] as? String
                    channel.profileImage = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async(execute: {
                    completion(videos)
                })
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()

    }
    
}
