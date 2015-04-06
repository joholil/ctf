//
//  startViewController.swift
//  Studie1
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit

class startViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func condition1Chosen()
    {
        globalCondition = 1
        if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("assignmentView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
    }

    
    @IBAction func condition2Chosen()
    {
        globalCondition = 2
        if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("progressTableView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
    }
    
    
    @IBAction func condition3Chosen()
    {
        globalCondition = 3
        if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("resultView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
    }
    
    
    @IBAction func resultChosen()
    {
        if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("resultView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)}
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
