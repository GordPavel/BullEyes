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
        
        roundScoreLabel.text = "Round score: \( roundScore )"
        totalScoreLabel.text = "Total score: \( totalScore )"
        roundNumberLabel.text = "Round number \( roundNumber )"
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
    
    @IBOutlet weak var sliderLabel: UILabel!{
        didSet{
            sliderValueChanged()
            sliderLabel.isHidden = true
        }
    }
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var goalNumberLabel : UILabel!
    @IBOutlet weak var roundScoreLabel : UILabel!
    @IBOutlet weak var totalScoreLabel : UILabel!
    @IBOutlet weak var roundNumberLabel : UILabel!
    
    var godMode = false
    @IBAction func godMode(_ sender: UIButton) {
        godMode = !godMode
        sliderLabel.isHidden = !godMode
        let underLined = godMode ? 1 : 0
        sender.setAttributedTitle( NSAttributedString(string: "God mode", attributes: [ NSUnderlineStyleAttributeName : underLined ] ), for: .normal )
    }
    @IBAction func game(){
        sliderLabel.isHidden = false
        
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
    
    @IBAction func info() {
        let alert = UIAlertController(title: "Tutorial", message: "You have to set on slider value, that label over it shows.", preferredStyle: .alert )
        let understandAction = UIAlertAction(title: "Understand", style: .default )
        alert.addAction( understandAction )
        present( alert , animated: true ) 
    }
    
    @IBAction func sliderValueChanged(){
        if !godMode{
            sliderLabel.isHidden = true
        }
        
        sliderLabel.text = "\( Int( roundf( slider.value ) ) )"
        let sliderPointWidth = slider.thumbRect( forBounds: slider.bounds, trackRect: slider.trackRect( forBounds: slider.bounds ), value: 0 ).size.width
        let leftMove = slider.frame.minX
        let allRange = ( slider.frame.width - sliderPointWidth ) * CGFloat( slider.value / slider.maximumValue )
        let middleOfSliferLabel = sliderLabel.frame.width / 2
        let x = leftMove + sliderPointWidth / 2 + allRange - middleOfSliferLabel
        sliderLabel.frame.origin = CGPoint( x: CGFloat(x) , y: sliderLabel.frame.minY )
    }
}

