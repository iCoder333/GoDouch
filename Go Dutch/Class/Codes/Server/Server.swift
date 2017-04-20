//
//  Server.swift
//  BLR Connect
//
//  Created by Michael Pieper on 7/23/16.
//  Copyright © 2016 Michal Pieper. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

open class Server: NSObject
{
    func getPhoneNumber(_ phoneNo : String) -> String {
        
        let phoneNumber = phoneNo.replacingOccurrences(of: "-", with: "")
        
        return PhoneNumberHelper().getMobileCountryCode() + phoneNumber
        
//        return "86" + phoneNumber

    }
    
    //MARK: Sign UP
    func registerUser(_ name: String, location: String, birthday: String, email: String, phone: String, photoData: Data, completion : @escaping (_ result : Bool, _ erorCode: Int, _ data : NSDictionary?) -> Void) {
        
        Alamofire.request(Server_Main_Url + Server_UserSignUp, method: .post, parameters: ["name": name, "location": location, "birthday": birthday, "email": email, "phone": self.getPhoneNumber(phone)], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let json = response.result.value as? NSDictionary
            {
                let status = json["status"] as! Int
                
                print(json)
                
                if status == Success_ServerRequest
                {
                    completion(true, status, json)
                }
                else
                {
                    completion(false, status, nil)
                }
            }
            else
            {
                completion(false, ERR_SYSTEM_PARAMTER_NOT_FOUND, nil)
            }
        }
        
//        Alamofire.request(.POST, Server_Main_Url + Server_UserSignUp, parameters: ["name" : name, "location": location, "birthday": birthday, "email": email, "phone": self.getPhoneNumber(phone)], encoding: .JSON).responseJSON { (response) in
//            if let json = response.result.value
//            {
//                let status = json["status"] as! Int
//                
//                print(json)
//                
//                if status == Success_ServerRequest
//                {
//                    completion(result: true, erorCode: status, data: json as? NSDictionary)
//                }
//                else
//                {
//                    completion(result: false, erorCode: status, data: nil)
//                }
//            }
//            else
//            {
//                completion(result: false, erorCode: ERR_SYSTEM_PARAMTER_NOT_FOUND, data: nil)
//            }
//        }
    }
    
    //MARK: Verify User
    func verifyUser(_ phone: String, state: String, completion : @escaping (_ result : Bool, _ data : NSDictionary?) -> Void) {
        
//        let phone1 = "13009083093"

        
        Alamofire.request(Server_Main_Url + Server_SetVerify, method: .post, parameters: ["phone": self.getPhoneNumber(phone), "state": state], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let json = response.result.value as? NSDictionary
            {
                let status = json["status"] as! Int
                
                if status == Success_ServerRequest
                {
                    let dict = json["userInfo"] as! NSDictionary
                    
                    completion(true, dict)
                }
                else
                {
                    completion(false, nil)
                }
            }
            else
            {
                completion(false, nil)
            }
        }
        
//        Alamofire.request(.POST, Server_Main_Url + Server_SetVerify, parameters: ["phone" : self.getPhoneNumber(phone), "state": state], encoding: .JSON).responseJSON { (response) in
//            if let json = response.result.value as? NSDictionary
//            {
//                let status = json["status"] as! Int
//                
//                if status == Success_ServerRequest
//                {
//                    let dict = json["userInfo"] as! NSDictionary
//                    
//                    completion(result: true, data: dict)
//                }
//                else
//                {
//                    completion(result: false, data: nil)
//                }
//            }
//            else
//            {
//                completion(result: false, data: nil)
//            }
//        }
    }
    
    //MARK: Log In User
    func signinUser(_ email: String, phone: String, completion : @escaping (_ result : Bool?, _ errorCode: Int? , _ data: NSDictionary? ) -> Void) {
        
//        var phone1 = "13009083093"
        
        Alamofire.request(Server_Main_Url + Server_UserLogIn, method: .post, parameters: ["email": email, "phone": self.getPhoneNumber(phone)], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let json = response.result.value as? NSDictionary
            {
                let status = json["status"] as! Int
                
                if status == Success_ServerRequest
                {
                    let dict = json["userInfo"] as! NSDictionary
                    
                    completion(true, status, dict)
                }
                else
                {
                    completion(false, status, nil)
                }
            }
            else
            {
                completion(false, Fail_ServerRequest, nil)
            }
        }

//        Alamofire.request(.POST, Server_Main_Url + Server_UserLogIn, parameters: ["email" : email, "phone": self.getPhoneNumber(phone)], encoding: .JSON).responseJSON { (response) in
//            if let json = response.result.value as? NSDictionary
//            {
//                let status = json["status"] as! Int
//                
//                if status == Success_ServerRequest
//                {
//                    let dict = json["userInfo"] as! NSDictionary
//                    
//                    completion(result: true, errorCode: status, data: dict)
//                }
//                else
//                {
//                    completion(result: false, errorCode: status, data: nil)
//                }
//            }
//            else
//            {
//                completion(result: false, errorCode: Fail_ServerRequest, data: nil)
//            }
//        }
    }
    
    //MARK: Resend Verify Code
    func resendVerifyCode(_ phone: String, completion : @escaping (_ result : Bool, _ data: NSDictionary?) -> Void) {
        
//        var phone1 = "13009083093"
        
        Alamofire.request(Server_Main_Url + Server_ResendVerifyCode, method: .post, parameters: ["phone": self.getPhoneNumber(phone)], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let json = response.result.value as? NSDictionary
            {
                let status = json["status"] as! Int
                
                if status == Success_ServerRequest
                {
                    completion(true, json)
                }
                else
                {
                    completion(false, nil)
                }
            }
            else
            {
                completion(false, nil)
            }
        }

//        Alamofire.request(.POST, Server_Main_Url + Server_ResendVerifyCode, parameters: ["phone" : self.getPhoneNumber(phone)], encoding: .JSON).responseJSON { (response) in
//            if let json = response.result.value as? NSDictionary
//            {
//                let status = json["status"] as! Int
//                
//                if status == Success_ServerRequest
//                {
//                    completion(result: true, data:  json as? NSDictionary)
//                }
//                else
//                {
//                    completion(result: false, data: nil)
//                }
//            }
//            else
//            {
//                completion(result: false, data:  nil)
//            }
//        }
    }
}
