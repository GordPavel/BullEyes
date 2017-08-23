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
        
        sliderLabel.text = "\( Int( roundf( slider.value ) ) )"
        let leftMove = slider.frame.minX
        let allRange = ( slider.frame.width - sliderPointWidth ) * CGFloat( slider.value / 100 )
        let middleOfSliferLabel = sliderLabel.frame.width / 2
        let x = leftMove + sliderPointWidth / 2 + allRange - middleOfSliferLabel
        sliderLabel.frame.origin = CGPoint( x: CGFloat(x) , y: slider.frame.midY - sliderLabel.frame.height / 2 )
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
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var goalNumberLabel : UILabel!
    @IBOutlet weak var roundScoreLabel : UILabel!
    @IBOutlet weak var totalScoreLabel : UILabel!
    @IBOutlet weak var roundNumberLabel : UILabel!
    
    @IBAction func game(){
        roundScore = abs( goalNumber - Int( roundf( slider.value ) ) )
        self.roundScoreLabel.text = "Round score: \(self.roundScore)"
        
        self.totalScore += self.roundScore
        self.totalScoreLabel.text = "Total score: \(self.totalScore)"
        
        self.roundNumber += 1
        self.roundNumberLabel.text = "Round number: \(self.roundNumber)"
            
        self.goalNumber = self.randomGenerator()
        self.goalNumberLabel.text = "Hit the \(self.goalNumber)!"
        
    }
    
    @IBAction func newGame(){
        goalNumber = randomGenerator()
        goalNumberLabel.text = "Hit the \(goalNumber)!"
        
        roundNumber = 1
        totalScore = 0
        
        roundScoreLabel.text = "Round score: "
        totalScoreLabel.text = "Total score: 0"
        roundNumberLabel.text = "Round number: 1"
    }
    
    var sliderPointWidth : CGFloat = 32.0
    @IBAction func sliderValueChanged( _ slider : UISlider ){
        sliderLabel.text = "\( Int( roundf( slider.value ) ) )"
        let leftMove = slider.frame.minX
        let allRange = ( slider.frame.width - sliderPointWidth ) * CGFloat( slider.value / slider.maximumValue )
        let middleOfSliferLabel = sliderLabel.frame.width / 2
        let x = leftMove + sliderPointWidth / 2 + allRange - middleOfSliferLabel
        sliderLabel.frame.origin = CGPoint( x: CGFloat(x) , y: sliderLabel.frame.minY )
    }
}

