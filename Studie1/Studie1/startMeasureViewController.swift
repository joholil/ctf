//
//  startMeasureViewController.swift
//  Studie1
//
//  Created by johahogb on 15/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit

class startMeasureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func StartMeasuring()
    {
 
 
    if globalCondition == 1{
        /*if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}*/
        performSegueWithIdentifier("segueStartmeasureAssignment", sender: nil)
    }
    else if globalCondition == 2{
        /*if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("progressTableView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
        */
        performSegueWithIdentifier("segueStartmeasureProgress", sender: nil)
    }
    else if globalCondition == 3{
        /*if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("resultView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}*/
        performSegueWithIdentifier("segueStartmeasureProgress", sender: nil)
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
