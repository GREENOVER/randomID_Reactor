# Reactor Random Network ID&Title View App
### 리액터로 랜덤하게 서버 통신하여 ID와 TITLE을 무작위로 보여주는 앱
#### 비동기 통신 및 리액터 처리 과정을 익히는 기능 중심 프로젝트로 UI가 아주아주 간단합니다.
***
## **✍️ 키워드**
- ReactorKit
- RxSwift
- RxCocoa
- MVVM
- Alamofire
- JSON
## **🧑🏻‍💻 구현사항**
- 뷰가 나타나고 ID/TITLE이 3초마다 랜덤하게 바뀌도록 구현하였습니다.
- 통신 버튼 클릭 시 3초를 기다리지 않고 즉시 ID/TITLE이 랜덤하게 바뀌도록 구현하였습니다.
- Alamofire를 통해 서버 통신하여 JSON 디코딩 파싱을 해주도록 구현하였습니다.
- 네트워크 및 디코딩 시 failure에 대처하여 원인 로그 파악을 위해 NSError를 반환하는 에러 메서드를 구현하였습니다.
## 🌲 **UI 및 기능 동작**
1. 3초마다 통신을 통해 랜덤한 뷰 변환 동작   
![random](https://user-images.githubusercontent.com/72292617/125147061-1c238080-e164-11eb-8320-69608f9a3cd4.gif)    
2. 버튼 클릭 시 즉각 랜덤한 뷰 변환 동작   
![click](https://user-images.githubusercontent.com/72292617/125147067-204f9e00-e164-11eb-8581-38045d7ce1fe.gif)  
## **코드 설명**
### 코드에 대한 자세한 설명은 아래 블로그에서 기술하였습니다📝
### [코드 설명보러 가기](https://green1229.tistory.com/154)
