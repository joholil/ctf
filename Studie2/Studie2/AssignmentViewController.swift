//
//  AssignmentViewController.swift
//  Studie2
//
//  Created by johahogb on 06/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController {
    
    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var alternativ1Button:UIButton!
    @IBOutlet var alternativ2Button:UIButton!
    @IBOutlet var alternativ3Button:UIButton!
    @IBOutlet var alternativ4Button:UIButton!
    @IBOutlet var questionTextview:UITextView!
    @IBOutlet var infotextTextview:UITextView!
    @IBOutlet var femtioFemtioButton:UIButton!
    @IBOutlet var andrasSvarButton:UIButton!

//    @IBOutlet var logoImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        self.alternativ1Button.setTitle(globalAssignments[globalCurrentAssignment].alternative1,forState: UIControlState.Normal)
        self.alternativ2Button.setTitle(globalAssignments[globalCurrentAssignment].alternative2,forState: UIControlState.Normal)
        self.alternativ3Button.setTitle(globalAssignments[globalCurrentAssignment].alternative3,forState: UIControlState.Normal)
        self.alternativ4Button.setTitle(globalAssignments[globalCurrentAssignment].alternative4,forState: UIControlState.Normal)
        self.infotextTextview.text = globalAssignments[globalCurrentAssignment].infoText
        self.questionTextview.text = globalAssignments[globalCurrentAssignment].question
 
        
        self.infotextTextview.selectable = false
        self.infotextTextview.editable = false
        
        self.questionTextview.editable = false
        self.questionTextview.selectable = false

        //self.femtioFemtioButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        //self.femtioFemtioButton.layer.borderWidth = 1
        //self.andrasSvarButton.layer.borderColor =  UIColor.lightGrayColor().CGColor
        //self.andrasSvarButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func alternative1Chosen()
    {
        globalAssignments[globalCurrentAssignment].userAnswer = 1
        performSegueWithIdentifier("segueVerification", sender: nil)
    }
    
    @IBAction func alternative2Chosen()
    {
        globalAssignments[globalCurrentAssignment].userAnswer = 2
        performSegueWithIdentifier("segueVerification", sender: nil)
    }

    @IBAction func alternative3Chosen()
    {
        globalAssignments[globalCurrentAssignment].userAnswer = 3
        performSegueWithIdentifier("segueVerification", sender: nil)
    }

    @IBAction func alternative4Chosen()
    {
        globalAssignments[globalCurrentAssignment].userAnswer = 4
        performSegueWithIdentifier("segueVerification", sender: nil)
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
