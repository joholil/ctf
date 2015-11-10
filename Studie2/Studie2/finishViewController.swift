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
        
        
        /*
        if globalAssignments[globalCurrentAssignment].isRightAnswer{
            message1 = "Du svarade rätt :) "
        }
        else{
            if globalAssignments[globalCurrentAssignment].isLateAnswer{
                message1 = "Du han inte lämna ditt svar i tid. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
            }
            else{
                message1 = "Fel. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret. "
            }
        }
        
        message3 = " Du hade sammanlagt " + String(Assignment.numberOfRightAnswers(globalAssignments)) + " rätt på " + String(globalAssignments.count) + " frågor. "
        
        if Assignment.numberOfRightAnswers(globalAssignments) >= globalRightAnswersForSuccess{
            message2 = " Du lyckades med utmaningen. Kom tillbaka till ingången för att få din kupong."
        }
        else{
            message2 = " Du lyckades inte med utmaningen. Du kan nu komma tillbaka till ingången."
        }
*/
        
        /*
            if globalAssignments[globalCurrentAssignment].isLateAnswer{
                self.resultAssignment.text = "Du han inte lämna ditt svar i tid. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
            }
            else{
                self.resultAssignment.text = "Fel. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
            }
        */
        
        //self.resultAssignment.text = message1 + message3 + message2
        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false

    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalAssignments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! resultTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline
        
        if globalAssignments[indexPath.row].isAnswered{
            if globalAssignments[indexPath.row].isRightAnswer {
                cell.resultLabel.text = "Rätt"
                cell.contentView.backgroundColor = UIColor (red: 96.0/255.0, green: 201.0/255.0, blue: 93.0/255.0, alpha: 1.0)
                
            }
            else{
                if globalAssignments[indexPath.row].isLateAnswer{
                    cell.resultLabel.text = "Sent svar"
                }
                else{
                    cell.resultLabel.text = "Fel"
                }
                cell.contentView.backgroundColor = UIColor (red: 242.0/255.0, green: 90.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            }
        }
        else{
            cell.resultLabel.text = ""
            cell.contentView.backgroundColor = UIColor (red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
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
