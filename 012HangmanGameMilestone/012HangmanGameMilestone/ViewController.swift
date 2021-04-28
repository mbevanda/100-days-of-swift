//
//  ViewController.swift
//  012HangmanGameMilestone
//
//  Created by Maja Bevada on 28.04.2021..
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var word: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWord()
    }
    
    func loadWord () {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String (contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
                word = allWords.randomElement()
            }
        }
    }
}

