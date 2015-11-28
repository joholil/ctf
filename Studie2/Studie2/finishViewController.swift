//
//  resultViewController.swift
//  Studie2
//
//  Created by johahogb on 07/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//


import Foundation
import UIKit
import CoreFoundation
import CoreData
import CoreLocation
import CoreBluetooth

class finishViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var resultAssignment:UITextView!
    @IBOutlet var finishedTextTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var message1:String = ""
        var message2:String = ""
        
        if globalAssignments[globalCurrentAssignment].isRightAnswer{
            self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " är rätt svar :)"
        }
        else{
            if globalAssignments[globalCurrentAssignment].isLateAnswer{
                self.resultAssignment.text = "Tiden är ute :("
            }
            else{
                self.resultAssignment.text = globalAssignments[globalCurrentAssignment].userAnswerText + " är fel svar :("
            }
        }

        message1 = "Du fick " + String(Assignment.numberOfRightAnswers(globalAssignments)) + " rätt av " + String(globalAssignments.count) + " möjliga. "
        
        if Assignment.numberOfRightAnswers(globalAssignments) >= globalRightAnswersForSuccess{
            message2 = "Du fick tillräckligt många poäng för att få en rabattkupong."
        }
        else{
            message2 = "Du fick inte tillräckligt många poäng för att få en rabattkupong."
        }
        
        self.finishedTextTextView.text = message1 + message2
        
        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false
        
        self.finishedTextTextView.selectable = false
        self.finishedTextTextView.editable = false

    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalAssignments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! resultTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline + ":"
        
        if globalAssignments[indexPath.row].isAnswered{
            cell.resultLabel.text = globalAssignments[indexPath.row].rightAnswerText
            if globalAssignments[indexPath.row].isRightAnswer {
            
                cell.contentView.backgroundColor = UIColor (red: 96.0/255.0, green: 201.0/255.0, blue: 93.0/255.0, alpha: 1.0)
                
            }
            else{
                cell.contentView.backgroundColor = UIColor (red: 242.0/255.0, green: 90.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            }
        }
        else{
            //cell.resultLabel.text = ""
            cell.contentView.backgroundColor = UIColor (red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            cell.resultLabel.hidden = true
        }
    
        
        return cell
        
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
