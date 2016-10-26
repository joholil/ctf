//
//  OfferViewController.swift
//  Studie3
//
//  Created by johahogb on 01/08/16.
//  Copyright © 2016 Service research center. All rights reserved.
//

import UIKit
import CoreData

class OfferViewController: UIViewController {
    
    var assignmentToShow:Int!
    
    @IBOutlet var offerLabel:UILabel!
    @IBOutlet var offerTextView:UITextView!
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!

    @IBOutlet var offerImageView:UIImageView!

    
    // </Timer>      ------------------------------//
    var localStartTime:NSTimeInterval = NSTimeInterval()
    var localTimer:NSTimer = NSTimer()
    // </Timer slut>      ------------------------------//
    
    //var startTime:CFAbsoluteTime = CFAbsoluteTime()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //offerLabel.text = globalAssignments[assignmentToShow].product
        //offerTextView.text = globalAssignments[assignmentToShow].offer
        
        localStartTime = NSDate.timeIntervalSinceReferenceDate()
        
        self.offerImageView.image = UIImage(named: globalAssignments[assignmentToShow].picture)
        
        
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

    
    @IBAction func BackToBuylist()
    {
        saveResult()
        
        performSegueWithIdentifier("segueBackToBuylist", sender: nil)
        
    }
    
    
    func saveResult(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                   
                    let currentTime = NSDate.timeIntervalSinceReferenceDate()
                    let elapsedTime = currentTime - localStartTime
                    
                    let managedObject = fetchResults[0]
                    switch assignmentToShow {
                    case 0:
                        globalAssignments[assignmentToShow].qtimelookingatoffer1 = globalAssignments[assignmentToShow].qtimelookingatoffer1 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer1, forKey: "timelookingatoffer1")
                        
                        managedObject.setValue(globaltimesoffer1clicked, forKey: "timesoffer1clicked")
                        
                        if globaltimesoffer1clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer1first")
                        }
                    case 1:
                        globalAssignments[assignmentToShow].qtimelookingatoffer2 = globalAssignments[assignmentToShow].qtimelookingatoffer2 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer2, forKey: "timelookingatoffer2")
                        
                        managedObject.setValue(globaltimesoffer2clicked, forKey: "timesoffer2clicked")
                        
                        if globaltimesoffer2clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer2first")
                            
                        }
                    case 2:
                        globalAssignments[assignmentToShow].qtimelookingatoffer3 = globalAssignments[assignmentToShow].qtimelookingatoffer3 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer3, forKey: "timelookingatoffer3")
                        
                        managedObject.setValue(globaltimesoffer3clicked, forKey: "timesoffer3clicked")
                        
                        if globaltimesoffer3clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer3first")
                            
                        }
                    case 3:
                        globalAssignments[assignmentToShow].qtimelookingatoffer4 = globalAssignments[assignmentToShow].qtimelookingatoffer4 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer4, forKey: "timelookingatoffer4")
                        
                        managedObject.setValue(globaltimesoffer4clicked, forKey: "timesoffer4clicked")
                        
                        if globaltimesoffer4clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer4first")
                            
                        }
                    case 4:
                        globalAssignments[assignmentToShow].qtimelookingatoffer5 = globalAssignments[assignmentToShow].qtimelookingatoffer5 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer5, forKey: "timelookingatoffer5")
                        
                        managedObject.setValue(globaltimesoffer5clicked, forKey: "timesoffer5clicked")
                        
                        if globaltimesoffer5clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer5first")
                            
                        }
                    case 5:
                        globalAssignments[assignmentToShow].qtimelookingatoffer6 = globalAssignments[assignmentToShow].qtimelookingatoffer6 + elapsedTime
                        managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer6, forKey: "timelookingatoffer6")
                        
                        managedObject.setValue(globaltimesoffer6clicked, forKey: "timesoffer6clicked")
                        
                        if globaltimesoffer6clicked == 1{
                            managedObject.setValue(elapsedTime, forKey: "timelookingatoffer6first")
                            
                        }
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
