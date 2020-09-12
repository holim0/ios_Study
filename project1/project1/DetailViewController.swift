//
//  DetailViewController.swift
//  project1
//
//  Created by 이희제 on 2020/09/12.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    
    var total : Int?
    var now: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture " + String(now!+1) + " of " + String(total!) // optional 이기 때문데 풀어준다.
        navigationItem.largeTitleDisplayMode = .never     // 타이틀을 무조건 작게 해준다.

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
