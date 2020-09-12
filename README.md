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
