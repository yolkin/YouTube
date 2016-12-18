//
//  TabBarCell.swift
//  YouTube
//
//  Created by Alexander on 14.12.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class TabBarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.lightGray
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            cellIcon.tintColor = isHighlighted ? UIColor.red : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            cellIcon.tintColor = isSelected ? UIColor.red : UIColor.lightGray
        }
    }
    
    func settingUpCell() {
        addSubview(cellIcon)
        
        let views = ["image": cellIcon]
        
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[image(28)]", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[image(28)]", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        addConstraints(horizontalContraints)
        addConstraints(verticalContraints)
        addConstraint(NSLayoutConstraint(item: cellIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cellIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
