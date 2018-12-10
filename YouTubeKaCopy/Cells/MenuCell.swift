//
//  MenuCell.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 06/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = menuCellTintColor
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : menuCellTintColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : menuCellTintColor
        }
    }
    
    override func setupViews(){
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func changeImage(imageName: String){
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
    }
}
