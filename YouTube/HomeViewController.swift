//
//  HomeViewController.swift
//  YouTube
//
//  Created by Alexander on 07.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let trendingReuseIdentifier = "trendingCell"
private let subscriptionReuseIdentifier = "subscriptionCell"
private let libraryReuseIdentifier = "libraryCell"


class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  YouTube"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
        navigationController?.hidesBarsOnSwipe = true
        
        setupCollectionView()
        customTabBar()
        setupNavigationBarButtons()
    }

    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        
        collectionView?.isScrollEnabled = false
        collectionView?.isPagingEnabled = true
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingReuseIdentifier)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionReuseIdentifier)
        collectionView?.register(LibraryCell.self, forCellWithReuseIdentifier: libraryReuseIdentifier)
    }
    
    lazy var tabBar: TabBar = {
        let tb = TabBar()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.homeViewController = self
        return tb
    }()
    
    let separatorForTabBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func customTabBar() {
        //navigationController?.hidesBarsOnSwipe = true
        
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
    
    func scrollToTabIndex(tabIndex: Int) {
        let indexPath = IndexPath(item: tabIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId: String
        
        if indexPath.item == 1 {
            reuseId = trendingReuseIdentifier
        } else if indexPath.item == 2 {
            reuseId = subscriptionReuseIdentifier
        } else if indexPath.item == 3 {
            reuseId = libraryReuseIdentifier
        } else {
            reuseId = reuseIdentifier
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}
