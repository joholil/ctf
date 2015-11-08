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
        //var inRange: Bool = false
        
        
        if (knownBeacons.count>0)
        {
            var i: Int = 0
            
            for elemenet in knownBeacons
            {
                if (knownBeacons[i].minor==target){
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
        /*
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate) managedObjectContext {
        
        var measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as! Measurement
        
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
        */
    }
    
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    func finished()
    {
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
        
        //if globalCurrentAssignment > globalAssignments.count - 1 {
        //    print("Varning: För många försök att spara har gjorts" )
        //}
        //else{
            
        saveMeasurement()
            //if globalCurrentAssignment == globalAssignments.count - 1
            //{
            //    globalCurrentAssignment = globalCurrentAssignment + 1 //Denna läggs på för att hantera om inte locationManager stängs ned som den ska.
            //}
        performSegueWithIdentifier("segueNewAssignment", sender: nil)
        //}
    }
    
    ////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if globalAssignments[globalCurrentAssignment].isRightAnswer{
            self.resultAssignment.text = "Du svarade rätt :)"
        }
        else{
            if globalAssignments[globalCurrentAssignment].isLateAnswer{
                self.resultAssignment.text = "Du han inte lämna ditt svar i tid. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
            }
            else{
                self.resultAssignment.text = "Fel. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
            }
        }
        
        globalCurrentAssignment = globalCurrentAssignment + 1
        self.nextAssignment.text = "Nu är det dags för nästa fråga. Gå vidare till " + globalAssignments[globalCurrentAssignment].headline.lowercaseString + "."
        
        self.nextAssignment.selectable = false
        self.nextAssignment.editable = false

        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalAssignments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! resultTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline
        
        if globalAssignments[indexPath.row].isAnswered{
            if globalAssignments[indexPath.row].isRightAnswer {
                cell.resultLabel.text = "Rätt"
                cell.contentView.backgroundColor = UIColor (red: 96.0/255.0, green: 201.0/255.0, blue: 93.0/255.0, alpha: 1.0)
            
            }
            else{
                if globalAssignments[indexPath.row].isLateAnswer{
                    cell.resultLabel.text = "Sent svar"
                }
                else{
                    cell.resultLabel.text = "Fel"
                }
                cell.contentView.backgroundColor = UIColor (red: 242.0/255.0, green: 90.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            }
        }
        else{
            cell.resultLabel.text = ""
            cell.contentView.backgroundColor = UIColor (red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
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
