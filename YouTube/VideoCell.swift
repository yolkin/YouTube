//
//  VideoCell.swift
//  YouTube
//
//  Created by Alexander on 07.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drake_hotline_bling")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drake")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let videoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Drake – Hotline Bling"
        return label
    }()
    
    let videoSubtitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "DrakeVEVO · 1 million views \n1 year ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    func customizeCell() {
        let cellItems = [thumbnailImage, separator, profileImage, videoTitle, videoSubtitle]
        
        for (_,subview) in cellItems.enumerated() {
            addSubview(subview)
        }
        
        let views = ["thumbnail": thumbnailImage, "separator": separator, "profileImage": profileImage]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[thumbnail]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[thumbnail]-8-[profileImage(44)]-16-[separator(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        let horizontalSeparatorConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        let horizontalProfileImageConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[profileImage(44)]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        //Video title constraints
        let topVideoTitleConstraint = NSLayoutConstraint(item: videoTitle, attribute: .top, relatedBy: .equal, toItem: thumbnailImage, attribute: .bottom, multiplier: 1, constant: 8)
        let leftVideoTitleConstraint = NSLayoutConstraint(item: videoTitle, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 8)
        let rightVideoTitleConstraint = NSLayoutConstraint(item: videoTitle, attribute: .right, relatedBy: .equal, toItem: thumbnailImage, attribute: .right, multiplier: 1, constant: 0)
        let heightVideoTitleConstraint = NSLayoutConstraint(item: videoTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        
        //Video subtitle constrains
        let topVideoSubtitleConstraint = NSLayoutConstraint(item: videoSubtitle, attribute: .top, relatedBy: .equal, toItem: videoTitle, attribute: .bottom, multiplier: 1, constant: 4)
        let leftVideoSubtitleConstraint = NSLayoutConstraint(item: videoSubtitle, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 8)
        let rightVideoSubtitleConstraint = NSLayoutConstraint(item: videoSubtitle, attribute: .right, relatedBy: .equal, toItem: thumbnailImage, attribute: .right, multiplier: 1, constant: 0)
        let heightVideoSubtitleConstraint = NSLayoutConstraint(item: videoSubtitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)
        
        let constraintsWithVisualFormat = [horizontalConstraints, verticalContraints, horizontalSeparatorConstraints, horizontalProfileImageConstraints]
        for (_, constraints) in constraintsWithVisualFormat.enumerated() {
            addConstraints(constraints)
        }
        
        let videoTitleAndSubtitleConstraints = [topVideoTitleConstraint, leftVideoTitleConstraint, rightVideoTitleConstraint, heightVideoTitleConstraint, topVideoSubtitleConstraint, leftVideoSubtitleConstraint, rightVideoSubtitleConstraint, heightVideoSubtitleConstraint]
        for (_, constraint) in videoTitleAndSubtitleConstraints.enumerated() {
            addConstraint(constraint)
        }

    }
    
}
