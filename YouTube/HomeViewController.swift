//
//  HomeViewController.swift
//  YouTube
//
//  Created by Alexander on 07.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video] = {
        var drakeChannel = Channel()
        drakeChannel.channelName = "DrakeVEVO"
        drakeChannel.profileImage = "drake"
        
        var hotlineBling = Video()
        hotlineBling.videoTitle = "Drake – Hotline Bling"
        hotlineBling.thumbnailImage = "drake_hotline_bling"
        hotlineBling.numberOfViews = "1 million views"
        hotlineBling.channel = drakeChannel
        
        var tamale = Video()
        tamale.videoTitle = "Tyler, The Creator – Tamale"
        tamale.thumbnailImage = "tamale"
        tamale.numberOfViews = "753 thousands views"
        tamale.channel = drakeChannel
        
        return [hotlineBling, tamale]
    }()
    
    let tabBar: TabBar = {
        let tb = TabBar()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let separatorForTabBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "YouTube"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        customTabBar()
        setupNavigationBarButtons()
    }
    
    func customTabBar() {
        view.addSubview(tabBar)
        view.addSubview(separatorForTabBar)
        
        let views = ["tabbar": tabBar, "separator": separatorForTabBar]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabbar]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[separator(1)]-0-[tabbar(50)]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let horizontalConstraintsForSeparator = NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
        view.addConstraints(horizontalConstraintsForSeparator)
    }
    
    func setupNavigationBarButtons() {
        let videoBarButton = UIBarButtonItem(image: UIImage(named: "video")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(videoAction))
        let searchBarButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchAction))
        let userProfileBarButton = UIBarButtonItem(image: UIImage(named: "user_profile")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(userProfileAction))
        
        navigationItem.rightBarButtonItems = [userProfileBarButton, searchBarButton, videoBarButton]
    }
    
    func videoAction() {
        
    }
    
    func searchAction() {
        
    }
    
    func userProfileAction() {
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 * 2) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
