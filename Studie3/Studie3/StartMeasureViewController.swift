//
//  StartMeasureViewController.swift
//  Studie2
//
//  Created by johahogb on 05/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit
import CoreData

class StartMeasureViewController: UIViewController {
    
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func StartExperiment()
    {
        globalStartTime = CFAbsoluteTimeGetCurrent()
        
        FinishMeasurement()
        performSegueWithIdentifier("segueBuylist", sender: nil)

    }
    
    func FinishMeasurement(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    
                    managedObject.setValue(globalStartTime, forKey: "startTime")
                    managedObject.setValue(globalCondition, forKey: "condition")
                    managedObject.setValue(globalAssignments.count, forKey: "totalAssignments")
                
                    try context.save()
                }
            }
        }
        catch{
            contents = nil
        }
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

