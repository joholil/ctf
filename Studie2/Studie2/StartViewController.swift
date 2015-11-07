//
//  StartViewController.swift
//  Studie2
//
//  Created by johahogb on 05/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

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
    
    @IBAction func condition1Chosen()
    {
        globalCondition = 1
        /*if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}*/
        performSegueWithIdentifier("segueStartStartmeasure", sender: nil)
    }
    
    @IBAction func condition2Chosen()
    {
        globalCondition = 2
        /*if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("progressTableView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
        */
        performSegueWithIdentifier("segueStartStartmeasure", sender: nil)
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
