//
//  ViewController.swift
//  Project2
//
//  Created by 이희제 on 2020/09/12.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    
    var countries = [String]()
    var score = 0
    var Answer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        btn1.layer.borderWidth  = 2
        btn2.layer.borderWidth  = 2
        btn3.layer.borderWidth  = 2
        
        btn1.layer.borderColor = UIColor.lightGray.cgColor
        btn2.layer.borderColor = UIColor.lightGray.cgColor
        btn3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action : UIAlertAction!){
        
        countries.shuffle()  // 리스트를 랜덤화 시킨다.
        Answer = Int.random(in: 0...2)
        
        btn1.setImage(UIImage(named: countries[0]), for: .normal)
        btn2.setImage(UIImage(named: countries[1]), for: .normal)
        btn3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[Answer].uppercased()
    }
    
    
    @IBAction func btn1Aciton(_ sender: UIButton) {
        var title: String
        
        if sender.tag == Answer {
            title = "Correct"
            score += 1
        } else{
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    
}

