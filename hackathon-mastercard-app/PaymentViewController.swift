//
//  PaymentViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet var sendButton: UIBarButtonItem!
    var kitIoT: IOTArduino!
    @IBAction func sendButton(sender: AnyObject) {
        
        
        let x = Int(arc4random_uniform(2))
        
        if x == 0 {
            
            kitIoT.sendCommandToArduino("#LB0000")
            kitIoT.sendCommandToArduino("#LG0000")
            kitIoT.sendCommandToArduino("#LR0255")
            
        }
        
        if x == 1 {
            
            kitIoT.sendCommandToArduino("#LB0255")
            kitIoT.sendCommandToArduino("#LG0000")
            kitIoT.sendCommandToArduino("#LR0000")
            
        }
        //kitIoT.sendCommandToArduino("#PM1234")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

