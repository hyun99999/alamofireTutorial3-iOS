# alamofireTutorial3-iOS
Alamofire 의 response handling, request http body 를 살펴보는 튜토리얼

### URLSession의 Request와 Response
- URLSession은 다른 HTTP 통신과 마찬가지로 Request와 Response를 기본 구조로 가지고 있습니다.
- 먼저 Request는 URL 객체를 통해 직접 통신하는 형태와, URLRequest 객체를 만들어서 옵션을 설정하여 통신하는 형태가 있습니다.
- 다음으로 Response는 설정된 Task의 Completion Handler 형태로 response를 받거나, URLSessionDelgate를 통해 지정된 메소드를 호출하는 형태로 response를 받는 형태가 있습니다.
 - 일반적으로 `Completion Handler` 를 통해서 response 를 작성하지만 앱이 백그라운드 상태에서 파일 다운로드를 받도록 지원하거나 인증과 캐싱을 default 옵션으로 사용하지 않는 상황과 같은 경우 `Delegate` 패턴을 사용한다.

### URLSession life cycle
1. `Session` configuration 을 결정하고 `Session` 을 생성한다.
2. 통신할 URL 과 Request 객체를 설정.
3. 사용할 `Task`를 결정하고 그에 맞는 `Completion Handler`나 `Delegate` 메서드를 작성.
4. 해당 `Task` 를 실행.
5. `Task` 완료 후 `Completion Handler` 실행.

### Alamofire
- alamofire 는 HTTP network requests 의 인터페이스를 제공.
- Foundation 프레임워크에서 제공하는 Apple 의 URL 로딩 시스템을 기반으로 구축. 즉, URLSession 과 URLSessionTask 하위클래스가 핵심이다.
- Alamofire 는 이러한 API 와 기타여러 API 를 상요학 쉬운 인터페이스로 래핑해서 제공.
- (UI 관련 작업은 메인쓰레드에서만 가능하다.)

### Alamofire 가 더 편리한 이유는?
- 외부 라이브러리를 사용한다는 것은 유지부분에서 단점이 될 수 있지만 잘 관리되면 매우 편하다.
- `AF.request()` 구문을 통해 쉽게 작성가능.
- response handlers 를 통해서 서버로부터의 Data 를 편하게 처리가능하며 성공과 실패를 스위치문으로 표현하기가 편하다.
> URLSession 에서는 completion handler 에 메서드를 작성.
- response validate() 즉 유효성 검사가 편하다.

### URLRequestFormParameterEncoder
```swift
 AF.request(url, method: .post, parameters: login, encoder: URLEncodedFormParameterEncoder.default).response { response in
            switch response.result{
            case .success:
                print("POST success!")
            case .failure(let err):
                print(err)
            }
```
- 파라미터를 인코딩해 기존의 URL 쿼리 문자열로 추가, URLRequest 의 HTTP body로 설정.
> URL 인코딩 매개변수가 있는 요청이다.
> 옵션으로 인코딩된 문자열이 설정될 위치를 컨트롤 할 수 있다. 즉 destination 옵션을 정할 수 있다.
- GET 에서는 기본적으로 .get 요청에 대한 쿼리 문자열에 적용(.httpBody)
  - url 뒤에 붙는 ? 뒤의 요청에 대한 쿼리 문자열로 적용
- POST 에서는 기본적으로 URLRequest 의 http body 로 설정.(.methodDependent)
  - id ...
  - qwd ... 로 파라미터가 전달됨.
  - 즉 http.body : "id []=...&pwd []=..." 형태로 전달

### JSONParameterEncoder
```swift
AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default).response { response in
            switch response.result{
            case .success:
                print("POST success!")
            case .failure(let err):
                print(err)
            }
```
- JSONEncoder 를 이용해서 Encodable 값을 인코딩하고 URLRequest 의 httpbody로 설정
- POST 에서는 기본적으로 http body 로 설정해서 json 으로 인코딩 된 값이 전달.
  - {"id":"1234","pwd":"1234"} 형태로 전달
  - header 로 authorize 해야함

### Response Validation
- 기본적으로 알라모파이어는 응답내용에 관계없이 완료된 요청을 성공으로 처리한다.
- validate() 를 지정하면 허용되지 않는 상태코드에 대해서 오류가 생성된다.(200..<300) 보통 200이 성공. 우리가 잘 아는 404.\
        
### GET request 의 response Handling
- response : response data 에 대해서 검증하지 않는다. 바로 URLSessionDelegate 로 보냄.
- responseData : 서버에서 반환된 Data 를 추출하고 유효성 검사.
- responseJSON : 서버에서 반환되 Data 를 Any 타입의 json object 로 변환
- responseString : 서버에서 반환된 Data 를 문자열로 변환
- responseDecodable : 서버에서 반환된 Data 를 전달된 Decodable 타입으로 변환

### 통신 결과
> https://ptsv2.com/t/9s58r-1615734388 통해서 post 통식 확인
- **URLRequestFormParameterEncoder**

<img src = "https://user-images.githubusercontent.com/69136340/111075692-946a9400-852c-11eb-9b04-8d84f11b5ddf.png" width="400">

- **JSONParameterEncoder**

<img src = "https://user-images.githubusercontent.com/69136340/111075690-916fa380-852c-11eb-9108-9092fa398b6e.png" width="300">
