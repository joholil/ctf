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

    @IBOutlet weak var background: UIImageView!
    
    //Här har jag inte använt funktion för Images. Jag har använt bilden direkt. Annars funkade det inte att göra förändringar av placering av bilden.
    @IBOutlet weak var kaulogo: UIImageView!
    
    
    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: globaluuid)
    let identifier = globalidentifier
    var accurazyZone: Double = globalaccurazyZone
    var maxDist: Int = globalmaxDist

    
    //var startTime = NSTimeInterval()
    
    //let beaconMajorValue:CLBeaconMajorValue = 65188
    //let beaconMinorValue:CLBeaconMinorValue = 1
    
    
    var allBeacons: [CLBeacon]?
    var knownBeacons = []
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        
        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }

/*
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, major: beaconMajorValue, minor: beaconMinorValue, identifier: identifier)
  
*/
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
        
        // för att spara batteri verkar det som att man först ska köra locationManager!.startMonitoringForRegion(beaconRegion) för att sedan när man hittat en iBeacon använda locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
        
        
/* kommer från eriks kod
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        */
        
        //self.background.image = UIImage(named: "bg__black_skattjakt")
        //self.kaulogo.image = UIImage(named: "kauLogo")
        self.kaulogo.hidden = false
        placeDot()

    }
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        //print("iBeacon found")
        
    }
    
    func placeDot(){
        //self.kaulogo.frame.size.height = self.background.frame.width/5
        //self.kaulogo.frame.size.width = self.background.frame.height
        self.kaulogo.center.x = (self.background.frame.width/2)
        self.kaulogo.center.y = self.background.frame.height - self.background.frame.height/10
        //self.kaulogo.hidden = false
    }
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        println("hej")
        // Do any additional setup after loading the view.
        //measurmentStartTime = CFAbsoluteTimeGetCurrent()
        //initializeAssignment()
        
    }
    */
    

    

    
    func moveDot(targeaccuracy:Double, maxDist: Int){
        // var maxDist: CGFloat = 20
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
        //println("maxdistasfloat" + maxDistAsFloat.description)
    }
    
   
    func beaconsInRange(target: Int, accuracyZone: Double, beacons: [AnyObject]! ){
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
                    
                    println("Target (" + target.description + ") Accuracy: " + temp2.description)
                        
                    moveDot(knownBeacons[i].accuracy, maxDist: maxDist)
                        
                    println("accuracyzone" + accurazyZone.description)
                        
                    if (knownBeacons[i].accuracy < accurazyZone){
                        hittad()
                    }
                }
                i = i + 1
            }
        }

        if (inRange) {
            self.kaulogo.hidden=false

        } else {
            placeDot()
            if self.kaulogo.hidden == false{
                self.kaulogo.hidden = true
            }
            else{
                self.kaulogo.hidden = false
            }
        }
        
        
    }
    
    
    func hittad() {
        //var userDefaults = NSUserDefaults.standardUserDefaults()
        //userDefaults.setInteger(1, forKey: "klarat1")
            
        //dot.image = dot.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        //dot.tintColor = UIColor.greenColor()
        locationManager.stopUpdatingLocation()
        hittadAlert()
        
    }
    func hittadAlert(){
        let alertController = UIAlertController(title: "Hittad :-)", message:
            "Bra jobbat", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Fortsätt", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
