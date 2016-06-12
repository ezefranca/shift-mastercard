//
//  ProtectedPageViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftLoader

class ProfileViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    
    var _userName: String!
    var _userEmail: String!
    var _url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.layer.cornerRadius = self.image.frame.size.width / 2;
        self.image.clipsToBounds = true;
        returnUserData()
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftLoader.show(title: "Checando CPF", animated: true)
        self.performSelector(#selector(ProfileViewController.cpfOk), withObject: nil, afterDelay: 3.0)
    }
    
    func cpfOk(){
        SwiftLoader.hide()
        SwiftLoader.show(title: "Calculando crédito....", animated: true)
        self.performSelector(#selector(ProfileViewController.creditoOk), withObject: nil, afterDelay: 3.0)
    }
    
    func creditoOk(){
        SwiftLoader.hide()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginPageNav
    }
    
    func returnUserData() {
        //if((FBSDKAccessToken.currentAccessToken()) != nil) {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, email, picture.type(large)"])
        
        graphRequest.startWithCompletionHandler({(connection, result, error) -> Void in
            if ((error) != nil) {
                print("Error: \(error)")
            } else {
                //                print("fetched user: \(result)")
                
                self._userName = result.valueForKey("name") as! String
                //                    print("User Name: \(self._userName)")
                //                    self._userEmail = result.valueForKey("email") as! String
                //                    print("User Email: \(self._userEmail)")
                self._url = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as! String
                print("Photo URL: \(self._url)")
                
                self.name.text = self._userName
                
                self.image.contentMode = UIViewContentMode.ScaleAspectFit
                let checkedUrl = NSURL(string: self._url)!
                self.downloadImage(checkedUrl)
            }
        })
        // }
    }
    
    func getDataFromUrl(urL: NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url: NSURL) {
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.image.image = UIImage(data: data!)
            }
        }
    }
    
    
    
    //    @IBAction func payButton(sender: AnyObject) {
    //        
    //        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("ProtectedPageViewController") as! ProtectedPageViewController
    //        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
    //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //        appDelegate.window?.rootViewController = protectedPageNav
    //    }
    
    
}
