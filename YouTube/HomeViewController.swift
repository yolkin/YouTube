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
    
    var videos: [Video]?
    
    func getVideos() {
        Maintenance.sharedInstance.getVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideos()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  YouTube"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel
        
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
        
        //self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        navigationController?.hidesBarsOnSwipe = true
        
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
        scrollToTabIndex(tabIndex: 2)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let colors: [UIColor] = [.red, .green, .yellow, .magenta]
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell
//        
//        cell.video = videos?[indexPath.item]
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 * 2) * 9 / 16
//        return CGSize(width: view.frame.width, height: height + 104)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }

}
