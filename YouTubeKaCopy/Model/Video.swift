//
//  Video.swift
//  YouTubeKaCopy
//
//  Created by Shivam Aditya on 10/12/18.
//  Copyright © 2018 Shivam Aditya. All rights reserved.
//

import Foundation
import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title : String?
    var channel : Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName : String?
}
