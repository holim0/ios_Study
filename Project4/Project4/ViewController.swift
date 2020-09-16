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
    var progressView : UIProgressView!
    var websites = ["apple.com", "youtube.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // 공간 차지 용도.
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let next = UIBarButtonItem(title : "next", style: .plain, target: webView, action: #selector(webView.goForward))
        
        let back = UIBarButtonItem(title: "back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        progressView = UIProgressView(progressViewStyle: .default)  // 새로 만들기
        progressView.sizeToFit() // 자동 채우기
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [back, progressButton, spacer, refresh, next]  //공간 배열이라고 생각.
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        let url  = URL(string: "https://" + websites[0])!   // 새로운 url 생성
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true   // 뒤로 가기 해주는 것.
        
        
    }
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page... ", message: nil, preferredStyle: .actionSheet)
        
        
        for website in websites
        {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction){
        
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "http://" + actionTitle) else { return }
        webView.load(URLRequest(url :url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url // 현재 url
        
       
        if let host = url?.host {
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
                
//                else{
//                    let bc = UIAlertController(title: "Rejected!", message: "You access wrong website!", preferredStyle: .alert)
//
//                   
//                    bc.addAction(UIAlertAction(title: "OK", style: .cancel))
//                    present(bc, animated: true)
//                }
                
            }
        }
            
        decisionHandler(.cancel)
    
        
    }

}

