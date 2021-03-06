//
//  resultViewController.swift
//  Studie2
//
//  Created by johahogb on 07/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//


import Foundation
import UIKit
import CoreFoundation
import CoreData
import CoreLocation
import CoreBluetooth

class resultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var resultAssignment:UITextView!
    @IBOutlet var nextAssignment:UITextView!
    
    var measurmentStartTime:CFAbsoluteTime = 0
    
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
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if(locationManager!.respondsToSelector("requestWhenInUseAuthorization")) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        
        
        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false
        
        self.nextAssignment.selectable = false
        self.nextAssignment.editable = false
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
    
        
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    func finished()
    {
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        performSegueWithIdentifier("segueNewAssignment", sender: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if globalAssignments[globalCurrentAssignment].isRightAnswer{
            
            if (globalEnglish){
                self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " is right :)"
            }
            else{
                self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " är rätt :)"
            }
            
            
        }
        else{
            if globalAssignments[globalCurrentAssignment].isLateAnswer{

                
                self.resultAssignment.text = "Tiden är ute :("
            }
            else{
                
                if (globalEnglish){
                    self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " is wrong :("
                }
                else{
                    self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " är fel :("
                }
      }
        }

        globalCurrentAssignment = globalCurrentAssignment + 1

        if (globalEnglish){
            self.nextAssignment.text = "Now go to " + globalAssignments[globalCurrentAssignment].headline.lowercaseString + "."
        }
        else{
            self.nextAssignment.text = "Gå nu till " + globalAssignments[globalCurrentAssignment].headline.lowercaseString + "."
        }
        
        self.nextAssignment.selectable = false
        self.nextAssignment.editable = false

        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var hej:Int = globalAssignments.count
        return globalAssignments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! resultTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline + ":"
        
        if globalAssignments[indexPath.row].isAnswered{
            cell.resultLabel.text = globalAssignments[indexPath.row].rightAnswerText
            if globalAssignments[indexPath.row].isRightAnswer {
                cell.contentView.backgroundColor = UIColor (red: 96.0/255.0, green: 201.0/255.0, blue: 93.0/255.0, alpha: 1.0)
            
            }
            else{
                cell.contentView.backgroundColor = UIColor (red: 242.0/255.0, green: 90.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            }
        }
        else{
            cell.contentView.backgroundColor = UIColor (red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            cell.resultLabel.hidden = true
        }

        return cell

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
