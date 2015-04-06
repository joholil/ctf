//
//  assignemntViewController.swift
//  Studie1
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreFoundation
import CoreData

class assignmentViewController: UIViewController {
    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var descriptionTestView:UITextView!
    @IBOutlet var logoImageView:UIImageView!
    
 

    var measurmentStartTime:CFAbsoluteTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
        initializeAssignment()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveMeasurement(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            var measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as Measurement
            
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            measurement.endTime = CFAbsoluteTimeGetCurrent()
            measurement.startTime = measurmentStartTime
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)" )
                return
            }
        }

    }
    
    
    func initializeAssignment()
    {
        measurmentStartTime = CFAbsoluteTimeGetCurrent()
        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        self.descriptionTestView.text = globalAssignments[globalCurrentAssignment].descriptionText
        self.logoImageView.image = UIImage(named: "kauLogo")
        
    }

    
    @IBAction func finished()
    {
        saveMeasurement()

        if globalCurrentAssignment == globalAssignments.count - 1
        {
            if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("finnishedView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)
            }
        }
        else if globalCondition == 1{

            globalCurrentAssignment = globalCurrentAssignment + 1;
            //initializeAssignment()
            if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)
            }
        
        }
        else if globalCondition == 2{
            globalCurrentAssignment = globalCurrentAssignment + 1;
            if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("progressTableView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
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