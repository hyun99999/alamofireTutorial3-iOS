//
//  ViewController.swift
//  alamofireTutorial3-iOS
//
//  Created by kimhyungyu on 2021/03/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickedPost(_ sender: UIButton) {
        postTest()
    }
    
    @IBAction func onClickedGet(_ sender: Any) {
        getTest()
    }
    //MARK: - get,post methods
    func getTest() {
        print("onClickedPost()")
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        AF.request(url).validate().responseJSON{
            response in
            switch response.result {
            case .success(let value):
                print("GET success!")
                let json = JSON(value)
                print(json)
                let userId = json["userId"].intValue
                let id = json["id"].intValue
                let title = json["title"].stringValue

                self.userIdLabel.text = String(userId)
                self.idLabel.text = String(id)
                self.titleLabel.text = title

            case .failure(let err):
                print(err)
            }
//        AF.request(url).validate().responseString{
//            response in
//            switch response.result {
//            case .success(let value):
//                print("GET success!")
//                print(value)
//            case .failure(let err):
//                print(err)
//            }
//        AF.request(url).validate().responseData{
//                    response in
//                    switch response.result {
//                    case .success(let value):
//                        print("GET success!")
//                        print(value)
//                    case .failure(let err):
//                        print(err)
//                    }
        }
//        Response Validation
//        기본적으로 알라모파이어는 응답내용에 관계없이 완료된 요청을 성공으로 처리한다. validate() 를 지정하면 허용되지 않는 상태코드에 대해서 오류가 생성된다.(200..<300) 보통 200이 성공. 우리가 잘 아는 404.\
//
//        GET request 의 response Handling
//        response : response data 에 대해서 검증하지 않는다. 바로 URLSessionDelegate 로 보냄.
//        responseData : 서버에서 반환된 Data 를 추출하고 유효성 검사.
//        responseJSON : 서버에서 반환되 Data 를 Any 타입의 json object 로 변환
//        responseString : 서버에서 반환된 Data 를 문자열로 변환
//        responseDecodable : 서버에서 반환된 Data 를 전달된 Decodable 타입으로 변환
        
    }
    func postTest() {
        print("onClickedGet()")
        
        let id = idTextField.text!
        let pwd = pwdTextField.text!
        
        let url = "https://ptsv2.com/t/9s58r-1615734388/post"
        //https://ptsv2.com/t/9s58r-1615734388
        
        let login:[String:String]=[
            "id":id,
            "pwd":pwd]
        
        AF.request(url, method: .post, parameters: login, encoder: URLEncodedFormParameterEncoder.default).response { response in
            switch response.result{
            case .success:
                print("POST success!")
            case .failure(let err):
                print(err)
            }
        }

//        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default).response { response in
//            switch response.result{
//            case .success:
//                print("POST success!")
//            case .failure(let err):
//                print(err)
//            }
//        }
            
        //HTTP Headers 사용
//        let headers: HTTPHeaders = [
//            .authorization(username: "Username", password: "Password"),
//            .accept("application/json")
//        ]
//        AF.request(url, headers: headers).responseJSON { response in
//            print("POST success!")
//        }

        //*URLEncodedFormParameterEncoder*
        //:파라미터를 인코딩해 기존의 URL 쿼리 문자열로 추가, URLRequest 의 HTTP body로 설정.
        //:URL 인코딩 매개변수가 있는 요청이다.
        //:옵션으로 인코딩된 문자열이 설정될 위치를 컨트롤 할 수 있다. 즉 destination 옵션을 정할 수 있다.
        //-GET 에서는 기본적으로 .get 요청에 대한 쿼리 문자열에 적용(.httpBody)
        //url 뒤에 붙는 ? 뒤의 요청에 대한 쿼리 문자열로 적용
        //-POST 에서는 기본적으로 URLRequest 의 http body 로 설정.(.methodDependent)
        //id ...
        //qwd ... 로 파라미터가 전달됨.
        //즉 http.body : "id []=...&pwd []=..." 형태로 전달
        
        //*JSONParameterEncoder*
        //JSONEncoder 를 이용해서 Encodable 값을 인코딩하고 URLRequest 의 httpbody로 설정
        //-POST 에서는 기본적으로 http body 로 설정해서 json 으로 인코딩 된 값이 전달.
        //{"id":"1234","pwd":"1234"} 형태로 전달
        
        //header 로 authorize
        //해야함
        

        
    }
}

