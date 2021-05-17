//
//  Photo.swift
//  016Milestone
//
//  Created by Maja Bevada on 17.05.2021..
//

import UIKit

class Photo: NSObject, Codable {
    var name: String
    var image: String
    
    init (name: String, image: String) {
        self.name = name
        self.image = image
    }

}
