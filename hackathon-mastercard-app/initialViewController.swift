//
//  initialViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/12/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import BWWalkthrough

public class InitialViewController : UIViewController, BWWalkthroughViewControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.show()
    }
    func show() {
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("walk1") as UIViewController
        let page_two = stb.instantiateViewControllerWithIdentifier("walk2") as UIViewController
        let page_three = stb.instantiateViewControllerWithIdentifier("login") as! LoginViewController
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        self.presentViewController(walkthrough, animated: true, completion: nil)
        
    }
    
    
}