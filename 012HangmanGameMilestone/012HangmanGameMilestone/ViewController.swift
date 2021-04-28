//
//  ViewController.swift
//  012HangmanGameMilestone
//
//  Created by Maja Bevada on 28.04.2021..
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var usedLetters = [String]()
    var word: String?
    var promptWord = ""
    
    @IBOutlet weak var solutionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWord()
        checkAnswer()
        solutionLabel.text = promptWord
    }
    
    func loadWord () {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String (contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
                word = allWords.randomElement()
            }
        }
    }
    
    func checkAnswer () {
        for letter in word! {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            }
            else {
                promptWord += "?"
            }
        }
    }
}

