//
//  ResultViewController.swift
//  Studie3
//
//  Created by johahogb on 03/08/16.
//  Copyright © 2016 Service research center. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
  
    @IBOutlet var resultLabel:UILabel!
    @IBOutlet var resultTextView:UITextView!
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!

    var assignmentToShow:Int!
    
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
