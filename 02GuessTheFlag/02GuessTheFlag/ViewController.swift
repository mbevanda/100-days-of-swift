//
//  ViewController.swift
//  02GuessTheFlag
//
//  Created by Maja Bevada on 29.03.2021..
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    // which flag holds correct answer
    var correctAnswer = 0
    var questionCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.prompt = "Score: \(score)"
            
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    
    func askQuestion (action: UIAlertAction! = nil){
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        
        if questionCounter >= 10 {
            let ac = UIAlertController(title: "Game over", message: "Finale score is \(score) out of 10", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .cancel, handler: end))
            present(ac, animated: true)
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        questionCounter += 1
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
            message = "Your score is \(score)"
            
        }
        else {
            title = "Wrong"
            message = "That's the flag of \(countries[sender.tag].uppercased())"
        }
       
        navigationItem.prompt = "Score: \(score)"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func end(action: UIAlertAction! = nil) {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
    }
}

