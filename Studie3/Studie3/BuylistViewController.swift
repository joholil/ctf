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

class BuylistViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var product1Button:UIButton!
    @IBOutlet var product2Button:UIButton!
    @IBOutlet var product3Button:UIButton!
    @IBOutlet var product4Button:UIButton!
    @IBOutlet var product5Button:UIButton!
    
    @IBOutlet var erbjudandeButton1:UIButton!
    @IBOutlet var erbjudandeButton2:UIButton!
    @IBOutlet var erbjudandeButton3:UIButton!
    @IBOutlet var erbjudandeButton4:UIButton!
    @IBOutlet var erbjudandeButton5:UIButton!
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!
    
    var measurmentStartTime:CFAbsoluteTime = 0
    var assignmentToShow:Int = 1
    
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
        initiateOfferButtons()
        
        initiateIbeacons()
        
        /*
         if (globalCondition == 2  ){
            initiateIbeacons()
        }
        else if globalCondition == 3{
            initiateIbeacons()
        }
 */
        
    }
    
    func initiateOfferButtons(){
        
        if (globalCondition == 1 || globalCondition == 2){
            for Assignment in globalAssignments
            {
                switch Assignment.assignmentNumber{
                case 1:
                    erbjudandeButton1.hidden = !Assignment.beacontriggered
                case 2:
                    erbjudandeButton2.hidden = !Assignment.beacontriggered
                case 3:
                    erbjudandeButton3.hidden = !Assignment.beacontriggered
                case 4:
                    erbjudandeButton4.hidden = !Assignment.beacontriggered
                case 5:
                    erbjudandeButton5.hidden = !Assignment.beacontriggered
                default: break
                    
                }
            }
        }
        else if globalCondition == 3{
            for Assignment in globalAssignments
            {
                if (Assignment.beacontriggered){
                    switch Assignment.assignmentNumber{
                    case 1:
                        erbjudandeButton1.hidden = !Assignment.isCorrectAnswer
                    case 2:
                        erbjudandeButton2.hidden = !Assignment.isCorrectAnswer
                    case 3:
                        erbjudandeButton3.hidden = !Assignment.isCorrectAnswer
                    case 4:
                        erbjudandeButton4.hidden = !Assignment.isCorrectAnswer
                    case 5:
                        erbjudandeButton5.hidden = !Assignment.isCorrectAnswer
                    default: break
                    }
                }
                else{
                    // I detta fall är frågan inte svarad på alltså ska erbjudandet inte synas.
                    switch Assignment.assignmentNumber{
                    case 1:
                        erbjudandeButton1.hidden = true
                    case 2:
                        erbjudandeButton2.hidden = true
                    case 3:
                        erbjudandeButton3.hidden = true
                    case 4:
                        erbjudandeButton4.hidden = true
                    case 5:
                        erbjudandeButton5.hidden = true
                    default: break
                    }
                }
            }
        }
    }
    
    func initiateIbeacons()
    {
        if(locationManager!.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization))) {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown } as NSArray
        
        beaconsInRange(accurazyZone, beacons: beacons)
        
    }
    
    
    func beaconsInRange(accuracyZone: Double, beacons: [AnyObject]! )-> Bool{
        
        if (knownBeacons.count>0)
        {
            for element in knownBeacons
            {
                    if (element.accuracy < accurazyZone){
                        beaconFound(element.minor)
                        return true
                    }
            }
        }
        return false
        
    }
    
    
    /*
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
    }
    */
    
    
    func beaconFound(beaconId:NSNumber)
    {
        var i:Int = 0
        
        for Assignment in globalAssignments
        {
            
            if (Assignment.beacontriggered != true)
            {
                //meddelandet ska bara visas en gång.
                if (Assignment.targetBeacon == beaconId)
                {
                    Assignment.beacontriggered = true
                    
                    if globalCondition == 1
                    {
                        initiateOfferButtons()
                    }
                    else if globalCondition == 2
                    {
                        assignmentToShow = i
                        performSegueWithIdentifier("segueOffer", sender: nil)
                    }
                    else if globalCondition == 3
                    {
                        assignmentToShow = i
                        performSegueWithIdentifier("segueGame", sender: nil)
                    }
                }
            }
            i = i + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        product1Button.setTitle(globalAssignments[0].product, forState: UIControlState.Normal)
        product2Button.setTitle(globalAssignments[1].product, forState: UIControlState.Normal)
        product3Button.setTitle(globalAssignments[2].product, forState: UIControlState.Normal)
        product4Button.setTitle(globalAssignments[3].product, forState: UIControlState.Normal)
        product5Button.setTitle(globalAssignments[4].product, forState: UIControlState.Normal)
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func erbjudande1ButtonChosen()
    {
        assignmentToShow = 0
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande2ButtonChosen()
    {
        assignmentToShow = 1
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande3ButtonChosen()
    {
        assignmentToShow = 2
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande4ButtonChosen()
    {
        assignmentToShow = 3
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande5ButtonChosen()
    {
        assignmentToShow = 4
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueOffer") {
            
            //Här sätts variabel i nästa visade dialog
            let NextViewController = (segue.destinationViewController as! OfferViewController)
            NextViewController.assignmentToShow = assignmentToShow
        }
        else if (segue.identifier == "segueGame")
        {
            //Här sätts variabel i nästa visade dialog
            let NextViewController = (segue.destinationViewController as! GameViewController)
            NextViewController.assignmentToShow = assignmentToShow
        }
    }
    
    @IBAction func product1ButtonChosen()
    {
        globalAssignments[0].checkedChange()
        product1Button.setAttributedTitle(getAttributeString(1), forState: UIControlState.Normal)
    }

    @IBAction func product2ButtonChosen()
    {
        globalAssignments[1].checkedChange()
        product2Button.setAttributedTitle(getAttributeString(2), forState: UIControlState.Normal)
    }
    
    @IBAction func product3ButtonChosen()
    {
        globalAssignments[2].checkedChange()
        product3Button.setAttributedTitle(getAttributeString(3), forState: UIControlState.Normal)
    }
    
    @IBAction func product4ButtonChosen()
    {
        globalAssignments[3].checkedChange()
        product4Button.setAttributedTitle(getAttributeString(4), forState: UIControlState.Normal)
    }
    
    @IBAction func product5ButtonChosen()
    {
        globalAssignments[4].checkedChange()
        product5Button.setAttributedTitle(getAttributeString(5), forState: UIControlState.Normal)
    }
    
    func getAttributeString(buttonNumber:Int) -> NSMutableAttributedString
    {
        let attributeString : NSMutableAttributedString
        
        if (globalAssignments[buttonNumber-1].checked){
            attributeString = NSMutableAttributedString(string: globalAssignments[buttonNumber-1].product)
            
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            
        }
        else{
            attributeString = NSMutableAttributedString(string: globalAssignments[buttonNumber-1].product)
            
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributeString.length))
            
        }
    
        return attributeString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func showparticipantIdButton()
    {
        
        self.visadeltagaridButton.hidden = false
    }
    
    
    @IBAction func showparticipantId()
    {
        
        self.visadeltagaridButton.hidden = true
        
        let alertControler = UIAlertController(title: "DeltagarId", message: globalDeltagarid, preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
        
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


