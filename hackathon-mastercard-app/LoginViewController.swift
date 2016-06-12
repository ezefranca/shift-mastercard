//
//  LoginViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import BWWalkthrough

class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: FBSDKLoginButton!
    var userName: String!
    var userEmail: String!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
        } else {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            callAnotherScreen()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController : FBSDKLoginButtonDelegate{
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error != nil) {
            print(error.localizedDescription)
            return
        }
        
        if (result.token != nil) {
            //Get user access token
            let token:FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            callAnotherScreen()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user is logged out")
    }
    
    func callAnotherScreen() {
        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        //let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = protectedPage
    }
    
}