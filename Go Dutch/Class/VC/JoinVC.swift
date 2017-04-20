//
//  JoinVC.swift
//  Go Dutch
//
//  Created by Florin Bogdan on 9/2/16.
//  Copyright © 2016 Sergey Bill. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import TwitterCore

class JoinVC: BasicVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTwitterAction(_ sender: AnyObject)
    {
        self.playSound(Sound_BtnClick)
        Twitter.sharedInstance().logIn { session, error in
            
            if (session != nil)
            {
                print(session?.userName);
                
                let user = UserModel()
                user.userid = "2"
                user.email = (session?.userName)! + "@twitter.com"
                user.verifyStatus = true
                UserDefaultsService.saveUser(user)
                
                DispatchQueue.main.async {

                
                }
            }
            else
            {
                print("error: \(error.debugDescription)");
            }
        }

    }
    
    @IBAction func loginFacebookAction(_ sender: AnyObject) {//action of the custom button in the storyboard
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        self.playSound(Sound_BtnClick)
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if fbloginresult.isCancelled == true
                {
                    return
                }
                
                if fbloginresult.grantedPermissions != nil && (fbloginresult.grantedPermissions.contains("email"))
                {   
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name ,picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    if let resultDict = result as? NSDictionary {
                        let user = UserModel()
                        user.userid = "1"
                        user.email = resultDict["email"] as? String
                        user.name = (resultDict["first_name"] as? String)! + " " + (resultDict["last_name"] as? String)!
                        
                        let picture = resultDict["picture"] as? NSDictionary
                        let data = picture!["data"] as? NSDictionary
                        user.photourl = data!["url"] as? String
                        
                        user.verifyStatus = true
                        UserDefaultsService.saveUser(user)
                        
                        self.performSegue(withIdentifier: "goPrefSelect", sender: nil)
                    }
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "goPrefSelect"
        {
            self.playSound(Sound_BtnClick)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
