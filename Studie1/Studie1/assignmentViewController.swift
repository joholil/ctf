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

class assignmentViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var descriptionTestView:UITextView!
    @IBOutlet var logoImageView:UIImageView!
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        descriptionTestView.selectable = false
        descriptionTestView.editable = false
    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        
    }
    
    func beaconsInRange(target: Int, accuracyZone: Double, beacons: [AnyObject]! )-> Bool{
        var inRange: Bool = false
       
        
        if (knownBeacons.count>0)
        {
            var i: Int = 0
            
            for elemenet in knownBeacons
            {
                
                if (knownBeacons[i].minor==target){
                    inRange = true
                    let temp: Double = round(knownBeacons[i].accuracy * 10)
                    let temp2: Double = temp/10
   
                    
                    if (knownBeacons[i].accuracy < accurazyZone){
                        finished()
                        
                        return true
                        
                        
                    }
                }
                i = i + 1
            }
        }
        return false
        
    }

    
    func saveMeasurement(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            let measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as! Measurement
            
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            measurement.endTime = CFAbsoluteTimeGetCurrent()
            measurement.startTime = measurmentStartTime
            measurement.participantNumber = globalParticipantNumber
            
            /*
            var e: NSError?
            if managedObjectContext.save() != true {
                print("insert error: \(e!.localizedDescription)" )
                return
            }
*/
        }

    }
    
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
        
        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        self.descriptionTestView.text = globalAssignments[globalCurrentAssignment].descriptionTextShort
        self.logoImageView.image = UIImage(named: "kauloggatrasnparentkant")
    }

    
    func finished()
    {
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        if globalCurrentAssignment > globalAssignments.count - 1 {
            print("Varning: För många försök att spara har gjorts" )
        }
        else{
            
            saveMeasurement()
            if globalCurrentAssignment == globalAssignments.count - 1
            {
                globalCurrentAssignment = globalCurrentAssignment + 1 //Denna läggs på för att hantera om inte locationManager stängs ned som den ska.
                performSegueWithIdentifier("segueAssignmentFinnish", sender: nil)
            }
            else if globalCondition == 1{ // Stay on this page
                
                globalCurrentAssignment = globalCurrentAssignment + 1
                
                let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
                locationManager.startRangingBeaconsInRegion(beaconRegion)
                
                initializeAssignment()
                
            }
            else if globalCondition == 2{ // Use progress bar
                globalCurrentAssignment = globalCurrentAssignment + 1;
                
                performSegueWithIdentifier("segueAssignmentProgress", sender: nil)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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