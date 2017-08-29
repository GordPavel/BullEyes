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
        
        totalScoreLabel.text = "Total score: \( totalScore )"
        roundNumberLabel.text = "Round number \( roundNumber )"
        
        slider.setThumbImage( (#imageLiteral(resourceName: "SliderThumb-Normal")), for: .normal )
        slider.setThumbImage( (#imageLiteral(resourceName: "SliderThumb-Highlighted")), for: .highlighted )
        slider.setThumbImage( (#imageLiteral(resourceName: "SliderThumb-Normal")) , for: .normal )
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10 )
        slider.setMinimumTrackImage( (#imageLiteral(resourceName: "SliderTrackLeft")).resizableImage(withCapInsets: insets ), for: .normal )
        slider.setMaximumTrackImage( (#imageLiteral(resourceName: "SliderTrackRight")).resizableImage(withCapInsets: insets ), for: .normal )
    
        let betweenbuttonAndLabel = ( hitMeButton.frame.minY + goalNumberLabel.frame.maxY ) / 2
        let sliderAndLabelsY = betweenbuttonAndLabel - slider.frame.height / 2
        slider.frame.origin.y = sliderAndLabelsY
        zeroLabel.frame.origin.y = sliderAndLabelsY
        hundredLabel.frame.origin.y = sliderAndLabelsY
        sliderValueChanged()
        sliderLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var randomGenerator = { return Int( arc4random_uniform( 99 ) + 1 ) }
    var seriesTuple = ( hundredPoints : 0.0 , fiftyPoints : 0.0 )
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
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var zeroLabel: UILabel!
    @IBOutlet weak var hundredLabel: UILabel!
    
    var godMode = false
    @IBAction func godMode( _ sender: UIButton) {
        godMode = !godMode
        sliderLabel.isHidden = !godMode
        let underLined = godMode ? 1 : 0
        sender.setAttributedTitle( NSAttributedString(string: "God mode", attributes: [ NSUnderlineStyleAttributeName : underLined ] ), for: .normal )
    }
    @IBAction func game(){
        sliderLabel.isHidden = false
        roundScore = 100 - abs( goalNumber - Int( roundf( slider.value ) ) )
        switch roundScore {
        case 100:
            seriesTuple.fiftyPoints = 0.0
        case 95..<100:
            seriesTuple.hundredPoints = 0.0
        default:
            seriesTuple.hundredPoints = 0.0
            seriesTuple.fiftyPoints = 0.0
        }

        let hundredPointsSeries = seriesTuple.hundredPoints >= 1.0 , fiftyPointsSeries = seriesTuple.fiftyPoints >= 1.0
        roundScoreLabel.text = "You scored \( roundScore ) points" + ( hundredPointsSeries ? " + \( Int( seriesTuple.hundredPoints ) ) * 100%" : "" ) + ( fiftyPointsSeries ?  " + \( Int( seriesTuple.fiftyPoints ) ) * 50%" : "" ) + ( hundredPointsSeries || fiftyPointsSeries ?  " bonus" : "" )
        
        totalScore += Int( Double( roundScore ) * ( 1.0 + seriesTuple.hundredPoints * 1.0 + seriesTuple.fiftyPoints * 0.5 ) )
        totalScoreLabel.text = "Total score: \(totalScore)"
        
        roundNumber += 1
        roundNumberLabel.text = "Round number: \(roundNumber)"
        
        goalNumber = randomGenerator()
        goalNumberLabel.text = "Hit the \(goalNumber)!"
        switch roundScore {
            case 100:
                seriesTuple.hundredPoints += 1.0
            case 95..<100:
                seriesTuple.fiftyPoints += 1.0
                seriesTuple.hundredPoints += 1.0
            default:
                break
        }
    }
    
    @IBAction func newGame(){
        goalNumber = randomGenerator()
        goalNumberLabel.text = "Hit the \(goalNumber)!"
        
        roundNumber = 1
        totalScore = 0
        
        seriesTuple = ( 0 , 0 )
        roundScoreLabel.text = ""
        totalScoreLabel.text = "Total score: 0"
        roundNumberLabel.text = "Round number: 1"
    }
    
    @IBAction func sliderValueChanged(){
        if !godMode{
            sliderLabel.isHidden = true
        }
        roundScoreLabel.text = ""
        sliderLabel.text = "\( Int( roundf( slider.value ) ) )"
        let thumbswidth = slider.thumbRect( forBounds: slider.bounds, trackRect: slider.trackRect( forBounds: slider.bounds ), value: 0 ).size.width
        let leftMove = slider.frame.minX
        let allRange = ( slider.frame.width - thumbswidth ) * CGFloat( slider.value / slider.maximumValue )
        let middleOfSliferLabel = sliderLabel.frame.width / 2
        sliderLabel.frame.origin = CGPoint( x: CGFloat( leftMove + thumbswidth / 2 + allRange - middleOfSliferLabel ) , y: slider.frame.midY - sliderLabel.frame.height / 2 )
    }
}

