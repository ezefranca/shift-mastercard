//
//  CreditCardViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/12/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func paymentButtonPressed(sender: UIButton) {
        let payment = SIMChargeCardViewController.init(publicKey: "sbpb_MDUxMTU4YjgtMDViMi00M2Y4LTgxZmItMjNiNzE3NGNiMDhh", primaryColor: UIColor.blueColor())
        
        payment.delegate = self
        payment.isCVCRequired = false
        payment.isZipRequired = false
        
        self.presentViewController(payment, animated: true, completion: nil)
    }
}



extension CreditCardViewController: SIMChargeCardViewControllerDelegate {
    func creditCardTokenProcessed(token: SIMCreditCardToken!) {
        print("Token: \(token)")
    }
    
    func chargeCardCancelled() {
    }
    
    func creditCardTokenFailedWithError(error: NSError!) {
    }
}