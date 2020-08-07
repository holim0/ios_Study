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
    
    var bombSoundEffect: AVAudioPlayer?
    @IBOutlet weak var bar: UIProgressView!
    @IBOutlet weak var titleName: UILabel!
    let times : [String : Float] = ["Soft" : 3.0 , "Medium" : 4.0, "Hard" : 7.0]
    
    var totalTime :Float = 0
    var timer = Timer()
    var Passed :Float = 0
    
    
    @IBAction func action(_ sender: UIButton) {
        self.bar.progress = 0.0
        timer.invalidate()
        
        
        let hardness = sender.currentTitle!
        self.titleName.text = hardness
        
        totalTime = times[hardness]!
        Passed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
     @objc func updateCounter() {
        //example functionality
        if Passed < totalTime {
            Passed += 1
            let per = Passed / totalTime
            self.bar.progress = Float(per)
            
            
            
        }else{
            timer.invalidate()
            self.titleName.text = "Done!"
            let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
            } catch {
                // couldn't load file :(
            }

        }
        
        
    }
    
    
    
    
}
