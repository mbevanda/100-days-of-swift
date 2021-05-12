//
//  Person.swift
//  013NamesToFaces
//
//  Created by Maja Bevada on 04.05.2021..
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init (name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    
}
