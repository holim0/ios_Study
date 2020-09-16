# 🍎IOS Study

### <Project 1-2020/09/12>

- 화면 전환 방식

1. ViewController의 view를 바꿔치기
2. ViewController가 다른 ViewController 호출(present)
3. NavigationController 사용하여 화면전환(push)
4. 화면전환용 객체 Segue 사용

</br>

Project 1 에서는 위의 4가지 방식 중에 3번째 방식을 사용하였다.

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{  // 다른 controller view를 호출한다. 여기서 "Detail" 은 다른 viewController의 ID이다.
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)  // 다음 뷰 컨트롤러 호출
        }
    }
```

- 로컬 파일 가져 오기

```swift
let fm = FileManager.default
        let path = Bundle.main.resourcePath!;
        let items = try! fm.contentsOfDirectory(atPath: path)
```
</br>

### <Project 2 -2020/09/15>

```swift
@IBOutlet var btn1: UIButton!

btn1.setImage(UIImage(named: countries[0]), for: .normal)
```

→  for: .normal 은 버튼의 표준 상태를 나타낼 때 사용된다. (UIImage 의 2번 째 인자)

</br>

```swift
countries += ["estonia", "france", "germany", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

countries.shuffle() // 리스트를 랜덤으로 정렬한다. 

```

shuffle 을 통해서 리스트를 랜덤화 할 수 있다. 

</br>

```swift
correctAnswer = Int.random(in: 0...2)

title = countries[correctAnswer].uppercased()  // 문자열을 다 대문자로 변환한다. 

```

→ Int.random(in: x...y) : x부터 y까지의 정수형 숫자를 랜덤하게 반환한다. 
</br>

- 각 이미지 뷰에는 tag 라는 value 가 존재하는데 이는 각 이미지 뷰를 판별할 때 사용될 수 있다.

<center><img width="253" alt="스크린샷 2020-09-16 오후 4 51 29" src="https://user-images.githubusercontent.com/48006103/93313613-ac927c80-f843-11ea-8f6e-c244b8c4e660.png"></center>


→  코드에서 나와 있듯이 sender.tag 를 통해서 이미지 뷰를 판단할 수 있다. 

```swift
@IBAction func btn1Aciton(_ sender: UIButton) {    // 버튼 액션 매소드
        var title: String
        var m: String = ""
        
        if sender.tag == Answer {
            title = "Correct"   //네비게이션 바의 타이틀.
            score += 1
        } else{
            title = "Wrong"
            m = "That's the flag of \(countries[sender.tag].uppercased())!"  
            score -= 1
        }
        
        if(cnt<10){
            m += "\nYour score is \(score)"
        }else{
            m += "\nYour final score is \(score)"
        }
```

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreTapped))
```

→ selector로 scoreTapped 를 전달하고 target은 현재 class 를 가리키는 self.

</br>

- UIAlertController

![IMG_5C034C00D4E8-1](https://user-images.githubusercontent.com/48006103/93313561-97b5e900-f843-11ea-9ca0-e55e6c931e1e.jpeg)

```swift
let ac = UIAlertController(title: title, message: m, preferredStyle: .alert) 
        
        if(cnt<10){
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) 
        }else {
            ac.addAction(UIAlertAction(title: "Finish", style: .default))
        }
        
        
        present(ac, animated: true)   // 화면에 표시해주는 메소드
```

→ addAction은 handler 를 통해 진행된다. 

→  preferredStyle 은 .alert 방식과 .actionSheet 방식이 있다. 

</br>


### <Project3 - 2020/09/15>


[**About UIActivityViewController]  →  공유 및 이미지 저장 할 수 있는 기능.**

- UIBarButtonItem

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
```

→ target 은 현재 class 인 self 를 가리키고 action 의 인자는 #selector 를 통해 shareTapped을 전달해준다. 

</br>

- shareTapped 함수

```swift
@objc func shareTapped(){
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("no image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, title!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
```
</br>

### <Project4 - 2020/09/16>

- WebView

```swift
override func loadView() {
        webView = WKWebView()  // webView 생성.
        webView.navigationDelegate = self  // 웹 페이지의 발생을 현재 class에 알려준다는 의미.
        view = webView // 현재 뷰를 웹 뷰로 할당.
    }
```

```swift
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
```
</br>

### <Project -2020/09/17>

- **UITableViewController**

```swift
//
//  ViewController.swift
//  Project5
//
//  Created by 이희제 on 2020/09/16.
//  Copyright © 2020 이희제. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
            
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
        
        
    }
    
    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData() // 다시 불러 온다.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count // 섹션의 row 개수
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "EnterAnswer", message: nil, preferredStyle: .alert)
        ac.addTextField()  // 텍스트 필드 추가
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in   //
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer : String){
        let lowerAnswer = answer.lowercased()   // 소문자로 만든다.
        
        let errorTitle : String
        let errorMessage :String
        
        
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    usedWords.insert(answer, at: 0)  // 배열 맨 앞에 answer 를 추가 한다.
                    let indexPath = IndexPath(row: 0, section: 0)           // 테이블 뷰에 추가하는 애니메이션 효과를 준다.  // tableView.reloadData()를 해도 된다.
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                }else{
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                }
            }else{
                errorTitle = "Word already used"
                errorMessage = "Be more original"
            }
        }else{
            
            guard let title = title else {return}
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title.lowercased())."
        }
        
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style : .default))
        
        present(ac, animated: true)
        
    }
    
    func isPossible (word: String) -> Bool{      // 조합 할 수 있는지 판단.
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word{  // title 에 있는 단어와 비교하는 반복문이다.
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool{     // 단어가 이미 사용되었는지 판단.
        return !usedWords.contains(word)
    }
    
    func isReal (word: String) -> Bool{     // 단어가 아닌것.
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)     // 진짜 존재하는 단어인지 판단 해준다. 
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

}
```

