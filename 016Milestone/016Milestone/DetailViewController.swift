//
//  DetailViewController.swift
//  016Milestone
//
//  Created by Maja Bevada on 14.05.2021..
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String!
    
    override func viewDidLoad() {
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(contentsOfFile: imageToLoad)
        }
    }   
}
