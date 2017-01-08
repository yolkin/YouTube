//
//  LibraryCell.swift
//  YouTube
//
//  Created by Alexander on 08.01.17.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class LibraryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let reuseId = "Cell"
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func customizeCell() {
        addSubview(collectionView)
        
        let views = ["cv": collectionView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[cv]|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        addConstraints(horizontalConstraints)
        addConstraints(verticalConstraints)
        
        collectionView.register(InnerCell.self, forCellWithReuseIdentifier: reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! InnerCell
        
        switch indexPath.item {
        case 1:
            cell.label.text = "My Videos"
            cell.imageView.image = UIImage(named: "my_videos")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
        case 2:
            cell.label.text = "Watch Later"
            cell.imageView.image = UIImage(named: "watch_later")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
            cell.separator.isHidden = false
        case 3:
            cell.playlistLabel.isHidden = false
            cell.imageView.isHidden = true
            cell.label.isHidden = true
        case 4:
            cell.label.isHidden = true
            cell.playlistNameLabel.isHidden = false
            cell.playlistNameLabel.text = "Favourite"
            cell.numberOfVideosLabel.isHidden = false
            cell.numberOfVideosLabel.text = "6 videos"
            cell.playlistImageView.isHidden = false
            cell.playlistImageView.image = UIImage(named: "filledStar")?.withRenderingMode(.alwaysTemplate)
            cell.playlistImageView.tintColor = .lightGray
        case 5:
            cell.label.isHidden = true
            cell.playlistNameLabel.isHidden = false
            cell.playlistNameLabel.text = "Liked"
            cell.numberOfVideosLabel.isHidden = false
            cell.numberOfVideosLabel.text = "27 videos"
            cell.playlistImageView.isHidden = false
            cell.playlistImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
            cell.playlistImageView.tintColor = .lightGray
        default:
            cell.label.text = "Viewed"
            cell.imageView.image = UIImage(named: "viewed")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class InnerCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        return iw
    }()
    
    let label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "Viewed"
        return lb
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let playlistLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .gray
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "Playlists"
        return lb
    }()
    
    let playlistNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    let numberOfVideosLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .gray
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    let playlistImageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.isHidden = true
        return iw
    }()
    
    func customizeCell() {
        addSubview(label)
        addSubview(imageView)
        addSubview(separator)
        addSubview(playlistLabel)
        addSubview(playlistNameLabel)
        addSubview(numberOfVideosLabel)
        addSubview(playlistImageView)
        
        let views = ["lb": label, "iw": imageView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[iw]-16-[lb]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[iw]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        playlistLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        playlistLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playlistImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        playlistImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        playlistImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        playlistNameLabel.leftAnchor.constraint(equalTo: playlistImageView.rightAnchor, constant: 16).isActive = true
        playlistNameLabel.topAnchor.constraint(equalTo: playlistImageView.topAnchor).isActive = true
        playlistNameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        numberOfVideosLabel.leftAnchor.constraint(equalTo: playlistImageView.rightAnchor, constant: 16).isActive = true
        numberOfVideosLabel.bottomAnchor.constraint(equalTo: playlistImageView.bottomAnchor).isActive = true
        numberOfVideosLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

}
