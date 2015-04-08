//
//  radarViewController.swift
//  Studie1
//
//  Created by johahogb on 08/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class radarViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    let identifier = "Estimote B9407F30"
    let beaconMajorValue:CLBeaconMajorValue = 65188
    let beaconMinorValue:CLBeaconMinorValue = 1
    
    /*
    var beacons:[CLBeacon]?
    var knownBeacons = []
    var accurazyZone:Double = 0.5
    
    
    var targetBeacon:Int = 1 //att göra
    */

    
    
    
    required init(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        locationManager.delegate = self
         print("init")
        
        

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let region = CLBeaconRegion(proximityUUID: uuid, major: beaconMajorValue, minor: beaconMinorValue, identifier: identifier)
        locationManager.startRangingBeaconsInRegion(region)
        
        if(!CLLocationManager.locationServicesEnabled())
        {
            let alertControler = UIAlertController(title: nil, message: "locationServicesEnabled var false", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            //You need to enable Location Services
        }
        if(!CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion))
        {
            let alertControler = UIAlertController(title: nil, message: "isMonitoringAvailableForClass var false", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
        //Region monitoring is not available for this Class;
        }
        
        
        /*if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted  )
        {
        //You need to authorize Location Services for the APP
        }
        */
        
         print("view did appear")
    }
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let alertControler = UIAlertController(title: nil, message: "Hittade en beacon didRangeBeacons", preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        let alertControler = UIAlertController(title: nil, message: "Hittade en beacon didEnterRegion", preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
    }
    
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        let alertControler = UIAlertController(title: nil, message: "Hittade en beacon didExitRegion", preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  /*
    func startTimer() {
        let aSelector : Selector = "updateTime"
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
        
        //startTime = NSDate.timeIntervalSinceReferenceDate()
    }

*/
   /*
    func updateTime() {
        
        /*
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        
        let testtime  = round(elapsedTime*10)
        if (testtime % 2 == 0) {
            even = 1
        }else{
            even = 0
        }
        if (elapsedTime >= 3) & (visaHittad == 0){
            visaHittad = 1
        }
        
        */
        

        
        //beaconsInRange(targetBeacon, odd: even, accuracyZone: accurazyZone)
       // beaconsInRange(targetBeacon, accuracyZone: accurazyZone)
        
        /* if (knownBeacons.count > 0) {
        //nearestBeaconProximityLables()
        // beaconInfo(0)
        //myDist()
        }*/  // För debug och test
        
    }*/
/*
    func beaconsInRange(target: Int, accuracyZone: Double){
        if (beacons?.count > 0 ){
            //  println("_______________________________Finns")
            if (knownBeacons.count>0){
                var i: Int = 0
                var inRange: Int = 0
                for elemenet in knownBeacons {
                    
                    if (knownBeacons[i].minor==target){
                        inRange = 1
                        let temp: Double = round(knownBeacons[i].accuracy * 10)
                        let temp2: Double = temp/10
                        
                        // joho println("Target (" + target.description + ") Accuracy: " + temp2.description)
                        
                        // joho moveDot(knownBeacons[i].accuracy, maxDist: maxDist)
                        
                        //joho println("accuracyzone" + accurazyZone.description)
                        
                        // joho if (knownBeacons[i].accuracy < accurazyZone){
                            
                            // johohittad(uppdrag, Klarat1: klarat1, Klarat2: klarat2, Klarat3: klarat3)
                        //joho }
                    }
                    i = i + 1
                }
                if (inRange == 1) {
                    //joho self.dot.hidden=false
                    println("_______________________________Target in range")
                } else {
                    println("_______________________________Target NOT in range")
                    // joho placeDot()
                    /* JOHO
                    if (odd==0 && target > 0) {
                        self.dot.hidden = false
                    }else{
                        self.dot.hidden=true
                    }
                    */
                
                }
            }
        } else {
            println("_______________________________ No beacons in range")
            /* joho
            placeDot()
            if (odd==0 && target > 0) {
                self.dot.hidden = false
            }else{
                self.dot.hidden=true
            }
            */
        }
    }
    
    */
    /*
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
