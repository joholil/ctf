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
    
    var test: Bool = false
    
    ///////////////////
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        initiateOfferButtons()
        initiateListButtons()
        
        initiateIbeacons()
        
        test = animated
    }
    
    func initiateListButtons(){
        
        product1Button.setAttributedTitle(getAttributeString(1), forState: UIControlState.Normal)
        product2Button.setAttributedTitle(getAttributeString(2), forState: UIControlState.Normal)
        product3Button.setAttributedTitle(getAttributeString(3), forState: UIControlState.Normal)
        product4Button.setAttributedTitle(getAttributeString(4), forState: UIControlState.Normal)
        product5Button.setAttributedTitle(getAttributeString(5), forState: UIControlState.Normal)
        
    }
    
    func initiateOfferButtons(){

        if (globalCondition == 1){
            if globalUseDynamicOfferbuttonsCondition1{
                
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
            else{
                erbjudandeButton1.hidden = false
                erbjudandeButton2.hidden = false
                erbjudandeButton3.hidden = false
                erbjudandeButton4.hidden = false
                erbjudandeButton5.hidden = false
            }
        }
        if (globalCondition == 2){
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
        
        //var beaconFoundInArray: Bool = false
        if (knownBeacons.count>0)
        {
            for element in knownBeacons
            {
                    if (element.accuracy < accurazyZone){
                        beaconFound(element.minor)
                    }
            }
        }
        return false
    }
    
    
    
    func beaconFound(beaconId:NSNumber)->Bool
    {
        var i:Int = 0
        
        for Assignment in globalAssignments
        {
            
            if (Assignment.beacontriggered != true)
            {
                //meddelandet ska bara visas en gång.
                if (Assignment.targetBeacon == beaconId)
                {
                    assignmentToShow = i
                    saveMeasurementActivationTime()
                    Assignment.beacontriggered = true
                    
                    if globalCondition == 1
                    {
                        initiateOfferButtons()
                 
                        return true
                        
                    }
                    else if globalCondition == 2
                    {
                        //assignmentToShow = i
                        
                        switch assignmentToShow {
                        case 0:
                            globaltimesoffer1clicked += 1
                        case 1:
                            globaltimesoffer2clicked += 1
                        case 2:
                            globaltimesoffer3clicked += 1
                        case 3:
                            globaltimesoffer4clicked += 1
                        case 4:
                            globaltimesoffer5clicked += 1
                        default:
                            break
                        }
                    
                        Alerter.VibrateAndSound()

                        performSegueWithIdentifier("segueOffer", sender: nil)
                        return true
                        
                    }
                    else if globalCondition == 3
                    {
                        //assignmentToShow = i
                        switch assignmentToShow {
                        case 0:
                            globaltimesoffer1clicked += 1
                        case 1:
                            globaltimesoffer2clicked += 1
                        case 2:
                            globaltimesoffer3clicked += 1
                        case 3:
                            globaltimesoffer4clicked += 1
                        case 4:
                            globaltimesoffer5clicked += 1
                        default:
                            break
                        }

                        Alerter.VibrateAndSound()

                        performSegueWithIdentifier("segueGame", sender: nil)
                        return true
                        
                    }
                }
            }
            i = i + 1
        }
        return false
    }
    
    func saveMeasurementActivationTime(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    switch assignmentToShow {
                    case 0:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment1activatedtime")
                    case 1:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment2activatedtime")
                    case 2:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment3activatedtime")
                    case 3:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment4activatedtime")
                    case 4:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment5activatedtime")
                    default:
                        break
                    }
                    
                    try context.save()
                }
            }
        }
        catch{
            contents = nil
        }
    }
    
    func saveMeasurementChecked(assignmentChecked:Int){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    switch assignmentChecked {
                    case 1:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment1checked")
                    case 2:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment2checked")
                    case 3:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment3checked")
                    case 4:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment4checked")
                    case 5:
                        managedObject.setValue(CFAbsoluteTimeGetCurrent(), forKey: "assignment5checked")
                    default:
                        break
                    }
                    
                    try context.save()
                }
            }
        }
        catch{
            contents = nil
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
        globaltimesoffer1clicked += 1
        saveMeasurementOffersClicked(1)
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande2ButtonChosen()
    {
        assignmentToShow = 1
        globaltimesoffer2clicked += 1
        saveMeasurementOffersClicked(2)
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande3ButtonChosen()
    {
        assignmentToShow = 2
        globaltimesoffer3clicked += 1
        saveMeasurementOffersClicked(3)
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande4ButtonChosen()
    {
        assignmentToShow = 3
        globaltimesoffer4clicked += 1
        saveMeasurementOffersClicked(4)
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    @IBAction func erbjudande5ButtonChosen()
    {
        assignmentToShow = 4
        globaltimesoffer5clicked += 1
        saveMeasurementOffersClicked(5)
        performSegueWithIdentifier("segueOffer", sender: nil)
    }
    
    
    
    func saveMeasurementOffersClicked(assignmentChecked:Int){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    switch assignmentChecked {
                    case 1:
                        managedObject.setValue(globaltimesoffer1clicked, forKey: "timesoffer1clicked")
                    case 2:
                        managedObject.setValue(globaltimesoffer2clicked, forKey: "timesoffer2clicked")
                    case 3:
                        managedObject.setValue(globaltimesoffer3clicked, forKey: "timesoffer3clicked")
                    case 4:
                        managedObject.setValue(globaltimesoffer4clicked, forKey: "timesoffer4clicked")
                    case 5:
                        managedObject.setValue(globaltimesoffer5clicked, forKey: "timesoffer5clicked")
                    default:
                        break
                    }
                    
                    try context.save()
                }
            }
        }
        catch{
            contents = nil
        }
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
        saveMeasurementChecked(1)
        product1Button.setAttributedTitle(getAttributeString(1), forState: UIControlState.Normal)
    }

    @IBAction func product2ButtonChosen()
    {
        globalAssignments[1].checkedChange()
        saveMeasurementChecked(2)
        product2Button.setAttributedTitle(getAttributeString(2), forState: UIControlState.Normal)
    }
    
    @IBAction func product3ButtonChosen()
    {
        globalAssignments[2].checkedChange()
        saveMeasurementChecked(3)
        product3Button.setAttributedTitle(getAttributeString(3), forState: UIControlState.Normal)
    }
    
    @IBAction func product4ButtonChosen()
    {
        globalAssignments[3].checkedChange()
        saveMeasurementChecked(4)
        product4Button.setAttributedTitle(getAttributeString(4), forState: UIControlState.Normal)
    }
    
    @IBAction func product5ButtonChosen()
    {
        globalAssignments[4].checkedChange()
        saveMeasurementChecked(5)
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


