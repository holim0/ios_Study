//
//  ViewController.swift
//  Project6b
//
//  Created by 이희제 on 2020/09/17.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "These"
        label1.sizeToFit()
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "Are"
        label2.sizeToFit()
        
        
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "some"
        label3.sizeToFit()
        
        
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "awesome"
        label4.sizeToFit()
        
        
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "labels"
        label5.sizeToFit()
        
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        // about VF
        
        
//        let viewDictionary = ["label1" : label1, "label2" : label2, "label3" : label3, "label4" : label4, "label5" : label5]
//
//
//        for label in viewDictionary.keys{
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
//        }
//
//        let metrixs = ["height" : 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(height@999)]-[label2(height)]-[label3(height)]-[label4(height)]-[label5(height)]-(>=10)-|", options: [], metrics: metrixs, views: viewDictionary))  // V는 vertical
//
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5]{
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true    // 전에 레이블이 있다면 10만큼 top에 간격을 준다.
            } else{
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true  // 없으면 세이프 구역으로부터 띄어준다. 
            }
            
            previous = label
        }
        
        
        
        
        
    }


}

