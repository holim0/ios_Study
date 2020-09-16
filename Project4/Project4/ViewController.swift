//
//  ViewController.swift
//  Project4
//
//  Created by 이희제 on 2020/09/16.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url  = URL(string: "https://www.apple.com/kr/")!   // 새로운 url 생성
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true   // 뒤로 가기 해주는 것.
        
        
    }
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page... ", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "naver.com", style: .default, handler: openPage))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)

               
               
        
    }

}

