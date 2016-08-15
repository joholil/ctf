//
//  ResultViewController.swift
//  Studie3
//
//  Created by johahogb on 03/08/16.
//  Copyright © 2016 Service research center. All rights reserved.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {
  
    @IBOutlet var resultLabel:UILabel!
    @IBOutlet var resultTextView:UITextView!
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!

    var assignmentToShow:Int!
    
    // </Timer>      ------------------------------//
    var localStartTime:NSTimeInterval = NSTimeInterval()
    var localTimer:NSTimer = NSTimer()
    // </Timer slut>      ------------------------------//
    
    var startTime:CFAbsoluteTime = CFAbsoluteTime()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if globalAssignments[assignmentToShow].isCorrectAnswer{
            resultLabel.text = "Grattis, du svarade rätt :)"
            resultTextView.text = "Du har låst upp erbjudandet \""  + globalAssignments[assignmentToShow].offer + "\""
            
        }
        else if globalAssignments[assignmentToShow].isLateAnswer{
            resultLabel.text = "Tyvärr, tiden är ute :("
            
            resultTextView.text = "Rätt svar var \"" + globalAssignments[assignmentToShow].rightAnswerText + "\"."
        }
        else{
            resultLabel.text = "Tyvärr, ditt svar var fel :("
            
            resultTextView.text = "Du svarade \"" + globalAssignments[assignmentToShow].userAnswerText + "\". " + "Rätt svar var \"" + globalAssignments[assignmentToShow].rightAnswerText + "\"."
         }
        
        localStartTime = NSDate.timeIntervalSinceReferenceDate()
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
        
        performSegueWithIdentifier("segueBackToBuylistFromResult", sender: nil)
        
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
                    
                    if globalAssignments[assignmentToShow].isCorrectAnswer{
                        let currentTime = NSDate.timeIntervalSinceReferenceDate()
                        let elapsedTime = currentTime - localStartTime
                        
                        let managedObject = fetchResults[0]
                        switch assignmentToShow {
                        case 0:
                            globalAssignments[assignmentToShow].qtimelookingatoffer1 = globalAssignments[assignmentToShow].qtimelookingatoffer1 + elapsedTime
                            managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer1, forKey: "timelookingatoffer1")
                            
                            if globaltimesoffer1clicked == 1{
                                managedObject.setValue(elapsedTime, forKey: "timelookingatoffer1first")
                            }
                        case 1:
                            globalAssignments[assignmentToShow].qtimelookingatoffer2 = globalAssignments[assignmentToShow].qtimelookingatoffer2 + elapsedTime
                            managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer2, forKey: "timelookingatoffer2")
                            if globaltimesoffer2clicked == 1{
                                managedObject.setValue(elapsedTime, forKey: "timelookingatoffer2first")
                                
                            }
                        case 2:
                            globalAssignments[assignmentToShow].qtimelookingatoffer3 = globalAssignments[assignmentToShow].qtimelookingatoffer3 + elapsedTime
                            managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer3, forKey: "timelookingatoffer3")
                            if globaltimesoffer3clicked == 1{
                                managedObject.setValue(elapsedTime, forKey: "timelookingatoffer3first")
                                
                            }
                        case 3:
                            globalAssignments[assignmentToShow].qtimelookingatoffer4 = globalAssignments[assignmentToShow].qtimelookingatoffer4 + elapsedTime
                            managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer4, forKey: "timelookingatoffer4")
                            if globaltimesoffer4clicked == 1{
                                managedObject.setValue(elapsedTime, forKey: "timelookingatoffer4first")
                                
                            }
                        case 4:
                            globalAssignments[assignmentToShow].qtimelookingatoffer5 = globalAssignments[assignmentToShow].qtimelookingatoffer5 + elapsedTime
                            managedObject.setValue(globalAssignments[assignmentToShow].qtimelookingatoffer5, forKey: "timelookingatoffer5")
                            if globaltimesoffer5clicked == 1{
                                managedObject.setValue(elapsedTime, forKey: "timelookingatoffer5first")
                                
                            }
                        default:
                            break
                        }
                        
                        
                        try context.save()
                    }
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
