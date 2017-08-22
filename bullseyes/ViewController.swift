//
//  ViewController.swift
//  bullseyes
//
//  Created by Павел Гордеев on 22.08.17.
//  Copyright © 2017 Павел Гордеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        goalNumber = randomGenerator()
        goalNumberLabel!.text = "Hit the \(goalNumber)!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var randomGenerator = { return Int( arc4random_uniform( 99 ) + 1 ) }

    var roundNumber = 1
    var roundScore = 0
    var totalScore = 0
    var goalNumber = 0
    
    @IBOutlet weak var slider : UISlider?
    @IBOutlet weak var goalNumberLabel : UILabel?
    @IBOutlet weak var roundScoreLabel : UILabel?
    @IBOutlet weak var totalScoreLabel : UILabel?
    @IBOutlet weak var roundNumberLabel : UILabel?
    
    @IBAction func game(){
        roundScore = abs( goalNumber - Int( roundf( slider!.value ) ) )
        
        let alert = UIAlertController(title: "Round!", message: "GoalNumber: \(goalNumber)\n" +
            "You scored: \( roundf( slider!.value ) )\n" +
            "RoundScore: \( roundScore )", preferredStyle: .alert )
        let action = UIAlertAction(title: "Ok", style: .default ){ ( _ ) in
            self.roundScoreLabel!.text = "Round score: \(self.roundScore)"
            
            self.totalScore += self.roundScore
            self.totalScoreLabel!.text = "Total score: \(self.totalScore)"
            
            self.roundNumber += 1
            self.roundNumberLabel!.text = "Round number: \(self.roundNumber)"
            
            self.goalNumber = self.randomGenerator()
            self.goalNumberLabel!.text = "Hit the \(self.goalNumber)!"
        }
        alert.addAction( action )
        self.present( alert, animated: true )
    }
    
    @IBAction func newGame(){
        goalNumber = randomGenerator()
        goalNumberLabel!.text = "Hit the \(goalNumber)!"
        
        slider!.value = 50.0
        roundNumber = 1
        totalScore = 0
        
        roundScoreLabel!.text = "Round score: "
        totalScoreLabel!.text = "Total score: 0"
        roundNumberLabel!.text = "Round number: 1"
    }
}

