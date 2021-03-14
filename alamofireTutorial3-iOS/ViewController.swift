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
        AF.request(url).responseJSON{
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
        }
        //GET request 의 response Handling
        //response
        //responseJSON
        //responseString
        //responseData
        //URLEncodedFormEncoder : 
        
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
        //*URLEncodedFormParameterEncoder*
        //:파라미터를 인코딩해 기존의 URL 쿼리 문자열로 추가, request 의 HTTP body로 설정.
        //:URL 인코딩 매개변수가 있는 요청이다.
        //:옵션으로 인코딩된 문자열이 설정될 위치를 컨트롤 할 수 있다.
        //-GET 에서는 기본적으로 .get 요청에 대한 쿼리 문자열에 적용
        //url 뒤에 붙는 ? 뒤의 요청에 대한 쿼리 문자열로 적용
        //-POST 에서는 기본적으로 URLRequest 의 http body 로 설정.
        //id ...
        //qwd ... 로 파라미터가 전달됨.
        //즉 http.body : "id []=...&pwd []=..." 형태로 전달
        
        //*JSONParameterEncoder*
        //parameters
        //header 로 authorize
        
    }
}

