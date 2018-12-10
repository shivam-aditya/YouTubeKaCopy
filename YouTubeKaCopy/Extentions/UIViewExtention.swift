//
//  UIViewExtention.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 05/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormatAndMetrics(format: String, metrics: [String : Any]?, views: UIView...) -> Void {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: viewsDictionary))
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) -> Void {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
}
