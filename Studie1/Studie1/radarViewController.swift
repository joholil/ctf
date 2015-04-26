//
//  radarViewController.swift
//  Studie1
//
//  Created by johahogb on 08/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import CoreBluetooth

class radarViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet var headlineLabel:UILabel!
    
    @IBOutlet var descriptionTextShort:UITextView!
    //Här har jag inte använt funktion för Images. Jag har använt bilden direkt. Annars funkade det inte att göra förändringar av placering av bilden.
    @IBOutlet weak var kaulogo: UIImageView!
    
    
    var measurmentStartTime:CFAbsoluteTime = 0
    
    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: globaluuid)
    let identifier = globalidentifier
    var accurazyZone: Double = globalaccurazyZone
    var maxDist: Int = globalmaxDist
    
    
    var allBeacons: [CLBeacon]?
    var knownBeacons = []
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeAssignment()
        
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        // för att spara batteri verkar det som att man först ska köra locationManager!.startMonitoringForRegion(beaconRegion) för att sedan när man hittat en iBeacon använda locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
        self.kaulogo.hidden = false
        placeDot()

    }
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        //print("iBeacon found")
        
    }
    
    func placeDot(){

        self.kaulogo.center.x = (self.background.frame.width/2)
        self.kaulogo.center.y = self.background.frame.height - self.background.frame.height/10
    }
    

    func moveDot(targeaccuracy:Double, maxDist: Int){
        var maxDistAsFloat = CGFloat(maxDist)
        var beaconspos: CGFloat = 0
        var accuracyAsFloat = CGFloat(targeaccuracy)
        var dotPosTop:CGFloat = self.background.frame.height
        var dotPosBottom: CGFloat = self.kaulogo.frame.height*2
        var dotPosDis:CGFloat = dotPosTop - dotPosBottom
        beaconspos = ((maxDistAsFloat-accuracyAsFloat)/maxDistAsFloat) * dotPosDis
        
        if (accuracyAsFloat < maxDistAsFloat){
            self.kaulogo.center.y =  self.background.frame.height + (self.kaulogo.frame.height/2)  - dotPosBottom - beaconspos
        } else {
            self.kaulogo.center.y =  self.background.frame.height + (self.kaulogo.frame.height/2)  - dotPosBottom
        }
        //self.kaulogo.center.x = (self.background.frame.width/2)
        //println("maxdistasfloat" + maxDistAsFloat.description)
    }
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
        self.descriptionTextShort.text = globalAssignments[globalCurrentAssignment].descriptionTextShort
        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        
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
                    //let temp: Double = round(knownBeacons[i].accuracy * 10)
                    //let temp2: Double = temp/10

                    moveDot(knownBeacons[i].accuracy, maxDist: maxDist)
                
                        
                    if (knownBeacons[i].accuracy < accurazyZone){
                        finished()
                        return true
                    }

                }

                i = i + 1
            }
        }
        else{
            placeDot()
        }
/*
        if (inRange) {

        } else {
            placeDot()
        }
*/
        return false
        
    }
    
    
    
    func finished()
    {
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        if globalCurrentAssignment > globalAssignments.count - 1 {
            println("Varning: För många försök att spara har gjorts" )
        }
        else{
            
            saveMeasurement()
            if globalCurrentAssignment == globalAssignments.count - 1
            {
                globalCurrentAssignment = globalCurrentAssignment + 1 //Denna läggs på för att hantera om inte locationManager stängs ned som den ska.
                performSegueWithIdentifier("segueRadarFinnished", sender: nil)
            }
            else if globalCondition == 3{ // Use radar bar Den här if
                globalCurrentAssignment = globalCurrentAssignment + 1;
                
                performSegueWithIdentifier("segueRadarProgress", sender: nil)
            }
        }
    }
    
    
    
    func saveMeasurement(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            var measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as! Measurement
            
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            measurement.endTime = CFAbsoluteTimeGetCurrent()
            measurement.startTime = measurmentStartTime
            measurement.participantNumber = globalParticipantNumber
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)" )
                return
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
