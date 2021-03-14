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
                print("ViewController - GET success!")
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
        
        
        let login:[String:String]=[
            "id":id,
            "pwd":pwd]
        
        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default).response { response in
            switch response.result{
            case .success:
                print("POST success!")
            case .failure(let err):
                print(err)
            }
        }
        //URLEncodedFormParameterEncoder
        //JSONParameterEncoder
        
        
    }
}

