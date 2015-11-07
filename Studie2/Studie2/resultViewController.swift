//
//  resultViewController.swift
//  Studie2
//
//  Created by johahogb on 07/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit
import Foundation

class resultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var resultAssignment:UITextView!
    @IBOutlet var nextAssignment:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if globalAssignments[globalCurrentAssignment].isRightAnswer{
            self.resultAssignment.text = "Du svarade rätt :)"
        }
        else{
            self.resultAssignment.text = "Fel. " + globalAssignments[globalCurrentAssignment].rightAnswerText + " är det rätta svaret."
        }
        
        self.nextAssignment.text = "Nu är det dags för nästa fråga. Gå vidare till " + globalAssignments[globalCurrentAssignment + 1].headline.lowercaseString + "."
        
        self.nextAssignment.selectable = false
        self.nextAssignment.editable = false

        self.resultAssignment.selectable = false
        self.resultAssignment.editable = false
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalAssignments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! resultTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline
        
        if globalAssignments[indexPath.row].isRightAnswer {
                cell.resultLabel.text = "Rätt"
                cell.contentView.backgroundColor = UIColor (red: 255.0/255.0, green: 215.0/255.0, blue: 60/255.0, alpha: 1.0)
            
        }
        else{
            cell.resultLabel.text = "Fel"
            cell.contentView.backgroundColor = UIColor.redColor()
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
