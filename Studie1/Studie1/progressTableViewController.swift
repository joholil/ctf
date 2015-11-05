//
//  progressTableViewController.swift
//  Studie1
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit

class progressTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return globalAssignments.count
        //return 3
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! progressTableViewCell
        
        cell.headlineLabel.text = globalAssignments[indexPath.row].headline
        
        
        if indexPath.row < globalCurrentAssignment{
            if indexPath.row == 0{
                cell.statusLabel.text = "20% finished!"
            }
            else if indexPath.row == 1{
                cell.statusLabel.text = "40% finished!"
            }
            else if indexPath.row == 2{
                cell.statusLabel.text = "60% finished!"
            }
            else if indexPath.row == 3{
                cell.statusLabel.text = "80% finished!"
            }
            cell.backgroundColor = UIColor.greenColor()
            
        }
        else if indexPath.row > globalCurrentAssignment{
            cell.statusLabel.text = ""
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        else{
            if globalCurrentAssignment == 0 {
                cell.statusLabel.text = "Press here to begin..."
                
            }
            else{
                cell.statusLabel.text = "Press here..."
                
            }
            
        }
        /*
        if indexPath.row < globalCurrentAssignment{
            if indexPath.row == 0{
                cell.statusLabel.text = "20% klart!"
            }
            else if indexPath.row == 1{
                cell.statusLabel.text = "40% klart!"
            }
            else if indexPath.row == 2{
                cell.statusLabel.text = "60% klart!"
            }
            else if indexPath.row == 3{
                cell.statusLabel.text = "80% klart!"
            }
            cell.backgroundColor = UIColor.greenColor()
            
        }
        else if indexPath.row > globalCurrentAssignment{
            cell.statusLabel.text = ""
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        else{
            if globalCurrentAssignment == 0 {
                cell.statusLabel.text = "Tryck här för att börja..."
                
            }
            else{
                cell.statusLabel.text = "Tryck här..."
                
            }
            
        }
        */
        return cell
    }
    
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == globalCurrentAssignment{
            if globalCondition == 2{ // Use progressbar
                performSegueWithIdentifier("segueProgressAssignment", sender: nil)
            }
            else if globalCondition == 3{ // Use radar
                performSegueWithIdentifier("segueProgressRadar", sender: nil)
            }
        }
        else{
        
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
