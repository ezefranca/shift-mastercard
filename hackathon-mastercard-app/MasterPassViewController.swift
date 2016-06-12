//
//  MasterPassViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/12/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import WebKit

class MasterPassViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        //let url = NSURL (string: "https://sandbox.wallet.masterpass.com/Wallet/masterpass/en-au/")
        let url = NSURL (string: "http://www.ezefranca.com/masterpass")
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj)
    }
}



extension MasterPassViewController: UIWebViewDelegate {
    
}
