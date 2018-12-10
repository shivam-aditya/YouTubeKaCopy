//
//  UIColorExtention.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 05/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alphaValue: CGFloat = 1) {
        self.init(red: redValue/255, green: greenValue/255, blue: blueValue/255, alpha: alphaValue)
    }
}
