//
//  AssignmentControlViewController.swift
//  Studie2
//
//  Created by johahogb on 14/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import CoreFoundation
import CoreData
import CoreLocation
import CoreBluetooth

class AssignmentControlViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var infotextTextview:UITextView!
    @IBOutlet var nextAssignment:UITextView!
    @IBOutlet var headlineLabel:UILabel!
  
    var startTime:CFAbsoluteTime = CFAbsoluteTime()

    
    ///////////IBeacon
    
    var allBeacons: [CLBeacon]?
    var knownBeacons = []
    var locationManager: CLLocationManager!
    let uuid = NSUUID(UUIDString: globaluuid)
    let identifier = globalidentifier
    var accurazyZone: Double = globalaccurazyZone
    var maxDist: Int = globalmaxDist
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    ///////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initiateView()
        
        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
    }

    func initiateView()
    {
        self.infotextTextview.text = globalAssignments[globalCurrentAssignment].infoText
        
        self.infotextTextview.selectable = false
        self.infotextTextview.editable = false
        
        self.nextAssignment.text = "\rGå nu till " + globalAssignments[globalCurrentAssignment].headline.lowercaseString + "."
        self.headlineLabel.text = "Information"
        
        startTime = CFAbsoluteTimeGetCurrent()

    }
    
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(globalAssignments[globalCurrentAssignment].targetBeacon, accuracyZone: accurazyZone, beacons: beacons)
        
    }
    
    func beaconsInRange(target: Int, accuracyZone: Double, beacons: [AnyObject]! )-> Bool{
        
        if (knownBeacons.count>0)
        {
            var i: Int = 0
            
            for element in knownBeacons
            {
                if (element.minor==target){
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

    func finishedAllAssignments(){
    
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        infotextTextview.text = ""
        nextAssignment.text = "Du är klar och kan hämta din rabattkupong."
        self.headlineLabel.text = "Du är nu klar!"
        
    }
    
    func finished()
    {
        
        if globalCurrentAssignment < globalAssignments.count - 1
        {
            globalCurrentAssignment = globalCurrentAssignment + 1
            
            UpdateMeasurement()
            initiateView() //Denna måste göras efter UpdateMeasurement
        }
        else{
            finishedAllAssignments()
            FinishMeasurement()
        }
    }
    
    func UpdateMeasurement(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarid == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    
                    
                    switch globalCurrentAssignment {
                    case (0):
                        managedObject.setValue(startTime, forKey: "assignment1StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment1EndTime")
                    case (1):
                        managedObject.setValue(startTime, forKey: "assignment2StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment2EndTime")
                    case (2):
                        managedObject.setValue(startTime, forKey: "assignment3StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment3EndTime")
                    case (3):
                        managedObject.setValue(startTime, forKey: "assignment4StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment4EndTime")
                    case (4):
                        managedObject.setValue(startTime, forKey: "assignment5StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment5EndTime")
                    case (5):
                        managedObject.setValue(startTime, forKey: "assignment6StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment6EndTime")
                    case (6):
                        managedObject.setValue(startTime, forKey: "assignment7StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment7EndTime")
                    case (7):
                        managedObject.setValue(startTime, forKey: "assignment8StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment8EndTime")
                    case (8):
                        managedObject.setValue(startTime, forKey: "assignment9StartTime")
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment9EndTime")
                    default: break
                        
                    }
                    
                    try context.save()
                }
            }
            
        } catch _ {
            contents = nil
        }
        
    }
    
    
    func FinishMeasurement(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarid == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    
                    managedObject.setValue(globalGameStartTime, forKey: "gameStartTime")
                    managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "gameEndTime")
                    managedObject.setValue(globalbuzzerUsed, forKey: "buzzerUsed")
                    managedObject.setValue(globalvisualWarningUsed, forKey: "visualWarningUsed")
                    managedObject.setValue(globalCondition, forKey: "condition")
                    
                    managedObject.setValue(Assignment.numberOfRightAnswers(globalAssignments), forKey: "totalrightAnswers")
                    managedObject.setValue(Assignment.numberOfAnswers(globalAssignments), forKey: "numberOfQuestionsAnswered")
                    
                    if (Assignment.numberOfRightAnswers(globalAssignments) >= globalRightAnswersForSuccess){
                        managedObject.setValue(true, forKey: "successfulGame")
                        
                    }
                    else {
                        managedObject.setValue(false, forKey: "successfulGame")
                        
                    }
                    
                    try context.save()
                }
            }
            
        }
        catch{
            contents = nil
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
