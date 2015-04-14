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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //radarfunktioner
    
    
    var allBeacons: [CLBeacon]?
    var knownBeacons = []
    
    
    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: globaluuid)
    let identifier = globalidentifier
    var accurazyZone: Double = globalaccurazyZone
    var maxDist: Int = globalmaxDist
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeAssignment()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
///////////////////////////////////////////////////////////////////////////////////////////////////////

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        //initializeAssignment()
        
        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
    }
    
    
    //radarfunktioner
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        locationManager.stopUpdatingLocation()
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        //print("iBeacon found")
        
    }
    
    func beaconsInRange(target: Int, accuracyZone: Double, beacons: [AnyObject]! )-> bool{
        var inRange: Bool = false
        
        if (knownBeacons.count>0)
        {
            var i: Int = 0
            
            for elemenet in knownBeacons
            {
                
                //println(knownBeacons[i].minor)
                
                if (knownBeacons[i].minor==target){
                    inRange = true
                    let temp: Double = round(knownBeacons[i].accuracy * 10)
                    let temp2: Double = temp/10
                    
                    //println("Target (" + target.description + ") Accuracy: " + temp2.description)
                    
                    //println("accuracyzone" + accurazyZone.description)
                    
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

    
//////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func saveMeasurement(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            var measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as Measurement
            
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            measurement.endTime = CFAbsoluteTimeGetCurrent()
            measurement.startTime = measurmentStartTime
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)" )
                return
            }
        }

    }
    
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
        
        println(globalCurrentAssignment)
        
        println(globalAssignments[globalCurrentAssignment].headline)
        
        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        self.descriptionTestView.text = globalAssignments[globalCurrentAssignment].descriptionText
        self.logoImageView.image = UIImage(named: "kauLogo")
        println(self.descriptionTestView.text)
        println(self.headlineLabel.text)
    }

    
    
    func finished()
    {
       
        
        saveMeasurement()

        if globalCurrentAssignment == globalAssignments.count - 1
        {
            if let newViewControler = storyboard?.instantiateViewControllerWithIdentifier("finnishedView") as?UIViewController {
                presentViewController(newViewControler, animated: true, completion: nil)
            }
        }
        else if globalCondition == 1{ // Stay on this page

            globalCurrentAssignment = globalCurrentAssignment + 1

            initializeAssignment()
            //initializeAssignment()
  
    /*
            var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: testar))
            self.presentViewController(alert, animated: true, completion: nil)
*/
            //println("asfd")
            /*
            if var newViewControler = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {
                presentViewController(newViewControler, animated: true, completion: nil)
                //showViewController(newViewControler, sender: newViewControler)

            }*/
        }
        else if globalCondition == 2{ // Use progress bar
            globalCurrentAssignment = globalCurrentAssignment + 1;
            //dismissViewControllerAnimated(true, completion:nil)
            /*
            if let newViewControler = storyboard?.instantiateViewControllerWithIdentifier("progressTableView") as?UIViewController {
                
                presentViewController(newViewControler, animated: true, completion: nil)
                //showViewController(newViewControler, sender: newViewControler)

            
            }*/

            
            performSegueWithIdentifier("segueAssignmentProgress", sender: nil)

        }
    }
    /*
    func testar(alert:UIAlertAction!){
        if var newViewControler = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {
            presentViewController(newViewControler, animated: true, completion: nil)
            
        }
    }
    */
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func shouldAutorotate() -> Bool {
        return false
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