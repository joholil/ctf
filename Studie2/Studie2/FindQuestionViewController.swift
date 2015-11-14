//
//  assignemntViewController.swift
//  Studie1
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreFoundation
import CoreData
import CoreLocation
import CoreBluetooth

class FindQuestionViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var descriptionTestView:UITextView!
    @IBOutlet var loggaImageView:UIImageView!
    
    var measurmentStartTime:CFAbsoluteTime = 0
    
    
    var allBeacons: [CLBeacon]?
    var knownBeacons = []
    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: globaluuid)
    let identifier = globalidentifier
    var accurazyZone: Double = globalaccurazyZone
    var maxDist: Int = globalmaxDist
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeAssignment()
        
        self.loggaImageView.image = UIImage(named: "kauloggatrasnparentkant.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        
    }
    
    func beaconsInRange(target: Int, accuracyZone: Double, beacons: [AnyObject]! )-> Bool{
        if (knownBeacons.count>0)
        {
            var i: Int = 0
            
            for elemenet in knownBeacons
            {
                
                if (elemenet.minor==target){
                    if (elemenet.accuracy < accurazyZone){
                        finished()
                        return true
                    }
                }
                i = i + 1
            }
        }
        return false
    }
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    func finished()
    {
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        if globalCondition == 1{
            
           performSegueWithIdentifier("segueAssignment", sender: nil)
            
        }
        else if globalCondition == 2{
            performSegueWithIdentifier("segueControlAssignment", sender: nil)
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}