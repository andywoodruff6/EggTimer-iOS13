//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes: [String: Int] = ["Soft": 5*60, "Medium": 7*60, "Hard": 12*60]
    //let softTime: Int = 5
    //let mediumTime: Int = 7
    //let hardTime: Int = 12
    var timer = Timer()
    var totalTime: Float = 0.0
    var secondsPassed: Float = 0.0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //print(sender.currentTitle)
        let hardness: String = sender.currentTitle!
        
        timer.invalidate()
        progressBarView.progress = 0.0
        secondsPassed = 0.0
        titleLabel.text = hardness
        
        totalTime = Float(eggTimes[hardness]!)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer( ) {
        if secondsPassed <= totalTime {
            print("\(secondsPassed) seconds.")
            updateProgressBarView()
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "DONE"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    func updateProgressBarView( ){
        progressBarView.progress = secondsPassed / totalTime
    }
}
//print(eggTimes[hardness]!)

// below is the long way around
//        switch hardness {
//        case "Soft":
//            print(eggTimes["Soft"]!)
//        case "Medium":
//            print(eggTimes["Medium"]!)
//        case "Hard":
//            print(eggTimes["Hard"]!)
//        default:
//            print("Error in hardness switch")
//        }
//
