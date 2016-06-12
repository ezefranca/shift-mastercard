//
//  ViewController.swift
//  hackathon-mastercard-app
//
//  Created by Ezequiel on 6/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sensor:SerialGATT!
    var peripheralViewControllerArray:[IOTArduino] = []
    var kitIoT: IOTArduino!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var scanButton: UIButton!
    
    @IBAction func scanButton(sender: AnyObject) {
        self.scan()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sensor = SerialGATT.init()
        sensor.setup()
        sensor.delegate = self
        kitIoT = IOTArduino.init()
        
    }
    func scanTimer(timer:NSTimer){
        
    }
    func scanGatewayMachines() {
        
    }
    
    
    //Botao
    func scan() {
        
        if sensor.activePeripheral != nil {
            if sensor.activePeripheral.state == .Connected{
                sensor.manager.cancelPeripheralConnection(sensor.activePeripheral)
                sensor.activePeripheral = nil
            }
        }
        
        if sensor.peripherals != nil {
            sensor.peripherals = nil
            peripheralViewControllerArray.removeAll()
            self.tableView.reloadData()
        }
        
        sensor.delegate = self;
        print("now we are searching device...\n");
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ViewController.scanTimer(_:)), userInfo: nil, repeats: false)
        
        sensor.findHMSoftPeripherals(5)
        
        self.tableView.reloadData()
        
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController : BTSmartSensorDelegate {
    
    func sensorReady()
    {
        //TODO: it seems useless right now.
    }
    
    func peripheralFound(peripheral: CBPeripheral!) {
        let kitNew = IOTArduino.init()
        kitNew.peripheral = peripheral
        kitNew.sensor = sensor
        peripheralViewControllerArray.append(kitNew)
        self.tableView.reloadData()
    }
    
    func setConnect() {
        print("OK+CONN")
    }
    
    func setDisconnect() {
        print("OK+LOST")
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row:Int = indexPath.row
        
        kitIoT = peripheralViewControllerArray[row]
        
        if sensor.activePeripheral != nil && sensor.activePeripheral != kitIoT.peripheral {
            sensor.disconnect(sensor.activePeripheral)
        }
        
        sensor.activePeripheral = kitIoT.peripheral
        sensor.connect(sensor.activePeripheral)
        sensor.stopScan()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PaymentViewController") as! PaymentViewController
        vc.kitIoT = kitIoT
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralViewControllerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellId = "peripheral"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        if cell == nil {
            cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        }
        
        
        let row:Int = indexPath.row
        kitIoT = peripheralViewControllerArray[row]
        
        let peripheral = kitIoT.peripheral
        cell?.textLabel?.text = peripheral.name
        cell?.accessoryType = .DetailDisclosureButton
        return cell!
        
        
    }
    
}
