//
//  ViewController.swift
//  WepServerDB
//
//  Created by SWUCOMPUTER on 21/05/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var lableResult: UILabel!
    @IBOutlet var picker: UIPickerView!
    
    var monthArray:[String] =  Array()
    var dayArray: [String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 1...12{monthArray.append("\(i)")}
        for i in 1...31{dayArray.append("\(i)")}
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return monthArray.count
        } else {
            return dayArray.count
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return monthArray[row] }
        else {
            return dayArray[row] }
    }
    
    @IBAction func whatDayPressed() {
        let month: String = monthArray[self.picker.selectedRow(inComponent: 0)]
        let day: String = dayArray[self.picker.selectedRow(inComponent: 1)]
        
     /*   if loginUserid.text == "" {
            labelStatus.text = "ID를 입력하세요"; return;
        }
        if loginPassword.text == "" {
            labelStatus.text = "비밀번호를 입력하세요"; return
        }  */
        
        //let urlString: String = "http://localhost:8888/login/loginUser.php"
        //let urlString: String = "http://condi.swu.ac.kr/student/login/loginUser.php"
        let urlString: String = "http://condi.swu.ac.kr/student/labs/findWhatDay.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        self.lableResult.text = " "
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "month=" + month + "&day=" + day
        
        request.httpBody = restString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            
            let response = response as! HTTPURLResponse
            if !(200...299 ~= response.statusCode) {
                print ("HTTP Error!")
                return
            }
            
            if let jsonData = String(data: receivedData, encoding: .utf8){
                DispatchQueue.main.async {
                        
                    self.lableResult.text = jsonData
                    
                    /*
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.ID = self.loginUserid.text
                    appDelegate.userName = name
*/
                    
                }
            }
        }
        task.resume()
        
        
    }
    
   


}


