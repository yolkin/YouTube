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
    
    let cellLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 10)
        lb.textColor = UIColor.lightGray
        return lb
    }()
    
    override var isHighlighted: Bool {
        didSet {
            cellIcon.tintColor = isHighlighted ? UIColor.red : UIColor.lightGray
            cellLabel.textColor = isHighlighted ? UIColor.red : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            cellIcon.tintColor = isSelected ? UIColor.red : UIColor.lightGray
            cellLabel.textColor = isSelected ? UIColor.red : UIColor.lightGray
        }
    }
    
    func settingUpCell() {
        addSubview(cellIcon)
        addSubview(cellLabel)
        
        let views = ["image": cellIcon, "label": cellLabel]
        
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[image(28)]", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[image(28)]-2-[label(11)]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        let horizontalLabelContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[label]", options: NSLayoutFormatOptions(), metrics: nil, views: views)
        
        addConstraints(horizontalContraints)
        addConstraints(verticalContraints)
        addConstraints(horizontalLabelContraints)
        addConstraint(NSLayoutConstraint(item: cellIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
        addConstraint(NSLayoutConstraint(item: cellLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 1))
    }
}
