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
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        customTabBar()
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 * 2) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
