//
//  ViewController.swift
//  project1
//
//  Created by 이희제 on 2020/09/12.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!;
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){ // 접두사에 nssl 들어간 이미지를 들고 온다.
                pictures.append(item)
            }
        }
        pictures.sort()
         
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{  // 다른 controller view를 호출한다. 여기서 "Detail" 은 다른 viewController의 ID이다.
            vc.selectedImage = pictures[indexPath.row]
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical  // 화면 전환 애니메이션 설정.
            vc.total = pictures.count
            vc.now = indexPath.row
            navigationController?.pushViewController(vc, animated: true)      // 다음 뷰 컨트롤러 호출
        }
    }

}

