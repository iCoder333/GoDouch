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
        
    }
    
    //MARK: Verify User
    func verifyUser(_ phone: String, state: String, completion : @escaping (_ result : Bool, _ data : NSDictionary?) -> Void) {
        
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
        
    }
    
    //MARK: Log In User
    func signinUser(_ email: String, phone: String, completion : @escaping (_ result : Bool?, _ errorCode: Int? , _ data: NSDictionary? ) -> Void) {

        
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

    }
    
    //MARK: Resend Verify Code
    func resendVerifyCode(_ phone: String, completion : @escaping (_ result : Bool, _ data: NSDictionary?) -> Void) {
        
        
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

    }
}
