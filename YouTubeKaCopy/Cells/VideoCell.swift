//
//  VideoCell.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 04/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation
import UIKit

class VideoCell : BaseCell {
    
//    var video : Video? = nil {
//        didSet{
//            titleLabel.text = video?.title
//
//            if let imageName = video?.thumbnailImageName {
//                let image = UIImage(named: imageName)
//                thumbnailImageView.image = image
//                thumbnailImageView.contentMode = UIView.ContentMode.scaleAspectFill
//                thumbnailImageView.clipsToBounds = true
//            }
//
//            if let profileImageName = video?.channel?.profileImageName {
//                let image = UIImage(named: profileImageName)
//                userProfileImageView.image = image
//                userProfileImageView.contentMode = UIView.ContentMode.scaleAspectFill
//                userProfileImageView.layer.cornerRadius = 22
//                userProfileImageView.clipsToBounds = true
//
//                subtitleLabel.text = video?.channel?.name
//            }
//
//        }
//    }
    
    var video : Items? = nil {
        didSet{
            titleLabel.text = video?.snippet?.title
            
//            if let imageName = video?.thumbnailImageName {
//                let image = UIImage(named: imageName)
//                thumbnailImageView.image = image
//                thumbnailImageView.contentMode = UIView.ContentMode.scaleAspectFill
//                thumbnailImageView.clipsToBounds = true
//            }
            
            if let urlString = video?.snippet?.thumbnails?.high?.url,
                let data = try? Data(contentsOf: URL(string: urlString)!)
            {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data:data)
                }
            }
            
            if let description = video?.snippet?.channelTitle {
                subtitleLabel.text = description
            }

//            if let profileImageName = video?.channel?.profileImageName {
//                let image = UIImage(named: profileImageName)
//                userProfileImageView.image = image
//                userProfileImageView.contentMode = UIView.ContentMode.scaleAspectFill
//                userProfileImageView.layer.cornerRadius = 22
//                userProfileImageView.clipsToBounds = true
//
//                subtitleLabel.text = video?.channel?.name
//            }
        }
    }
    
    let thumbnailImageView : UIImageView = {
       let imageView = UIImageView()
        //imageView.backgroundColor = .blue
        let image = UIImage(named: "MereNaamTu")
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .green
        let image = UIImage(named: "srk-zoomed")
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let seperatorview : UIView = {
        let view = UIView()
        //view.backgroundColor = .black
        view.backgroundColor = seperatorColor
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ZERO: Mere Naam Tu Song | Shah Rukh Khan, Anushka Sharma, Katrina Kaif | T-Series"
        label.numberOfLines = 2
        return label
    }()
    
//    let subtitleTextView : UITextView = {
//        let textView = UITextView()
//        //textView.backgroundColor = .red
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.text = "T-Series • 33,007,463 views • 1 week ago "
//        //✅ ✓
//        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
//        textView.textColor = UIColor.lightGray
//        textView.isEditable = false
//        return textView
//    }()
    
    let subtitleLabel : UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "T-Series • 33,007,463 views • 1 week ago "
        textView.textColor = UIColor.lightGray
        textView.numberOfLines = 2
        textView.font = textView.font.withSize(14)
        return textView
    }()
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(seperatorview)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        //horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorview)

        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-48-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorview)

        //adding custom constaint for titleLabel
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constaint
        //addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: subtitleLabel, attribute: .height, multiplier: 1, constant: 0))
        
        
        //adding custom constaint for subtitleLabel
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constaint
        //addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))

        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|", options: [], metrics: nil, views: ["v0" : thumbnailImageView, "v1" : seperatorview]))
//        thumbnailImageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}
