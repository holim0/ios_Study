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

