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
        getVideosForUrlString(urlString: "https://www.dropbox.com/s/4aeaxexlfkpf4j8/home.json?dl=1", completion: completion)
    }
    
    func getTrendingVideos(completion: @escaping ([Video]) -> ()) {
        getVideosForUrlString(urlString: "https://www.dropbox.com/s/rym7mw3j29eq8dx/trending.json?dl=1", completion: completion)
    }

    func getSubscriptionVideos(completion: @escaping ([Video]) -> ()) {
        getVideosForUrlString(urlString: "https://www.dropbox.com/s/0deay7a5euq85qq/subscription.json?dl=1", completion: completion)
    }

    func getVideosForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
        
                    DispatchQueue.main.async(execute: {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
}
