//
//  BaseCell.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 06/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews(){
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
