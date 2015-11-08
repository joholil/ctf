//
//  VerificationViewController.swift
//  Studie2
//
//  Created by johahogb on 07/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var userAnswerTextview:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        self.userAnswerTextview.text = globalAssignments[globalCurrentAssignment].userAnswerText
        
        
    }
    
    @IBAction func yesChosen()
    {
        saveMeasurement()

        
        if globalCurrentAssignment < globalAssignments.count - 1 {
            performSegueWithIdentifier("segueResult", sender: nil)
        }
        else{
            performSegueWithIdentifier("segueFinish", sender: nil)
        }
    }
    
    @IBAction func noChosen()
    {
        performSegueWithIdentifier("segueAssignmentBack", sender: nil)
    }
    
    func saveMeasurement(){
        
        
        /*
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            var measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as! Measurement
            
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            measurement.endTime = CFAbsoluteTimeGetCurrent()
            measurement.startTime = measurmentStartTime
            measurement.participantNumber = globalParticipantNumber
 
            
        }
        */
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
