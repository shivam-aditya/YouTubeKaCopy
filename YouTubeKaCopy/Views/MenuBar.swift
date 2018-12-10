//
//  MenuBar.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 06/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = defaultRedColor
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let imageNames = ["home","trending","subscriptions","account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuBarCollectionViewCellIdentifier)
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        setInitialTab()
    }
    
    fileprivate func setInitialTab() {
        let initialIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: initialIndexPath, animated: false, scrollPosition: .centeredVertically)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuBarCollectionViewCellIdentifier, for: indexPath) as! MenuCell
        cell.changeImage(imageName: imageNames[indexPath.item])
        cell.tintColor = menuCellTintColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
