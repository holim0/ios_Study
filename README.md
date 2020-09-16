# 🍎IOS Study

### <Project 1-2020/09/12>

- 화면 전환 방식

1. ViewController의 view를 바꿔치기
2. ViewController가 다른 ViewController 호출(present)
3. NavigationController 사용하여 화면전환(push)
4. 화면전환용 객체 Segue 사용

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


### <Project 2 -2020/09/15>

```swift
@IBOutlet var btn1: UIButton!

btn1.setImage(UIImage(named: countries[0]), for: .normal)
```

→  for: .normal 은 버튼의 표준 상태를 나타낼 때 사용된다. (UIImage 의 2번 째 인자)

```swift
countries += ["estonia", "france", "germany", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

countries.shuffle() // 리스트를 랜덤으로 정렬한다. 

```

shuffle 을 통해서 리스트를 랜덤화 할 수 있다. 

```swift
correctAnswer = Int.random(in: 0...2)

title = countries[correctAnswer].uppercased()  // 문자열을 다 대문자로 변환한다. 

```

→ Int.random(in: x...y) : x부터 y까지의 정수형 숫자를 랜덤하게 반환한다. 

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
