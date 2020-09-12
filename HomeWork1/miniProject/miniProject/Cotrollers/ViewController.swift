//
//  ViewController.swift
//  miniProject
//
//  Created by 이희제 on 2020/09/10.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Gobtn: UIButton!
    @IBOutlet weak var Img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func goSecond(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goSecond", sender: self)
        
    }
    
    
}

