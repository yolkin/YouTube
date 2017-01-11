//
//  VideoInfo.swift
//  YouTube
//
//  Created by Alexander on 06.01.17.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class VideoInfoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVideoInfoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.text = "XXXXXXXX"
        return label
    }()
    
    let numberOfViewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "999 999 views"
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "169"
        return label
    }()
    
    let numberOfDislikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "5"
        return label
    }()
    
    let separator1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separator2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: ModifiedImageView = {
        let imageView = ModifiedImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "drake")
        return imageView
    }()
    
    let channelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "DrakeVEVO"
        return label
    }()
    
    let numberOfFollowersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "777 111 followers"
        return label
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "subscribe"), for: .normal)
        return button
    }()
    
    func setupVideoInfoView() {
        addSubview(titleLabel)
        addSubview(numberOfViewsLabel)
        addSubview(likeButton)
        addSubview(numberOfLikesLabel)
        addSubview(dislikeButton)
        addSubview(numberOfDislikesLabel)
        addSubview(separator1)
        addSubview(separator2)
        addSubview(profileImage)
        addSubview(channelNameLabel)
        addSubview(numberOfFollowersLabel)
        addSubview(subscribeButton)
        
        let views = ["title": titleLabel, "numOfViews": numberOfViewsLabel, "like": likeButton, "separator1": separator1, "separator2": separator2, "subscribe": subscribeButton]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[title(40)]-8-[numOfViews(13)]-8-[like(25)]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        //numberOfViews constraints
        addConstraint(NSLayoutConstraint(item: numberOfViewsLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: numberOfViewsLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        
        //likeButton constraints
        addConstraint(NSLayoutConstraint(item: likeButton, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: likeButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 25))
        
        
        //numberOfLikes constraints
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .left, relatedBy: .equal, toItem: likeButton, attribute: .right, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 35))
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 25))
        addConstraint(NSLayoutConstraint(item: numberOfLikesLabel, attribute: .top, relatedBy: .equal, toItem: numberOfViewsLabel, attribute: .bottom, multiplier: 1, constant: 8))
        
        
        //dislikeButton contraints
        addConstraint(NSLayoutConstraint(item: dislikeButton, attribute: .left, relatedBy: .equal, toItem: numberOfLikesLabel, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: dislikeButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 25))
        addConstraint(NSLayoutConstraint(item: dislikeButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 25))
        addConstraint(NSLayoutConstraint(item: dislikeButton, attribute: .top, relatedBy: .equal, toItem: numberOfViewsLabel, attribute: .bottom, multiplier: 1, constant: 8))
        
        //numberOfDislikes constraints
        addConstraint(NSLayoutConstraint(item: numberOfDislikesLabel, attribute: .left, relatedBy: .equal, toItem: dislikeButton, attribute: .right, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: numberOfDislikesLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 35))
        addConstraint(NSLayoutConstraint(item: numberOfDislikesLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 25))
        addConstraint(NSLayoutConstraint(item: numberOfDislikesLabel, attribute: .top, relatedBy: .equal, toItem: numberOfViewsLabel, attribute: .bottom, multiplier: 1, constant: 8))
        
        //separator1 constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator1]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraint(NSLayoutConstraint(item: separator1, attribute: .top, relatedBy: .equal, toItem: likeButton, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: separator1, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
        
        //profileImage constraints
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .left, relatedBy: .equal, toItem: likeButton, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 36))
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 36))
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: separator1, attribute: .bottom, multiplier: 1, constant: 8))
        
        //channelName constraints
        addConstraint(NSLayoutConstraint(item: channelNameLabel, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: channelNameLabel, attribute: .right, relatedBy: .equal, toItem: subscribeButton, attribute: .left, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: channelNameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 16))
        addConstraint(NSLayoutConstraint(item: channelNameLabel, attribute: .top, relatedBy: .equal, toItem: separator1, attribute: .bottom, multiplier: 1, constant: 8))
        
        //numberOfFollowers constraints
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .right, relatedBy: .equal, toItem: subscribeButton, attribute: .left, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 14))
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .top, relatedBy: .equal, toItem: channelNameLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //subscribe constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[subscribe]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 125))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 36))
        addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .top, relatedBy: .equal, toItem: separator1, attribute: .bottom, multiplier: 1, constant: 8))
        
        //separator2 constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separator2]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraint(NSLayoutConstraint(item: separator2, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: separator2, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
    }
    
}
