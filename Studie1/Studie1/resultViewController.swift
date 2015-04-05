//
//  resultViewController.swift
//  Studie1
//
//  Created by johahogb on 05/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreData

class resultViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    //var assignment:Assignment!
    
    var measurements:[Measurement] = []
    //var measurment:Measurment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeForm()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initializeForm(){
        
        var fetchResultController:NSFetchedResultsController!
        var fetchRequest = NSFetchRequest(entityName: "Measurement")
        let sortDescriptor = NSSortDescriptor(key: "headline", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            measurements = fetchResultController.fetchedObjects as [Measurement]
            
            if result != true {
                println(e?.localizedDescription)
            }
        }
    }
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return measurements.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as resultTableViewCell
                
                cell.tidLabel.text = measurements[indexPath.row].duration()
                cell.headlineLabel.text = measurements[indexPath.row].headline
                return cell
                
    }
    
    @IBAction func deleteMeasurments(){
    
        let alertControler = UIAlertController(title: nil, message: "Vill du radera alla mätningar?", preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ja", style: UIAlertActionStyle.Default, handler: deleteMeasurments))
        alertControler.addAction(UIAlertAction(title: "Nej", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
    }
    
    func deleteMeasurments(alert: UIAlertAction!) {
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            
            for measurementToDelete in measurements{
                managedObjectContext.deleteObject(measurementToDelete)
            }
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("delete error: \(e!.localizedDescription)")
            }
            if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("startView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func backToStart(){
        if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("startView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)
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
