//
//  StartViewController.swift
//  Studie2
//
//  Created by johahogb on 05/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit
import CoreData

class StartViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var deltagaridTextview:UITextField!
    @IBOutlet var ejSparadeTextview:UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // görs för att stänga keyboard efter retur
        self.deltagaridTextview.delegate = self
        
        self.ejSparadeTextview.selectable = false
        self.ejSparadeTextview.text = nonSavedMeasures()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method to dismiss keyboard on return key press
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Method to dismiss keyboard by touching to anywhere on the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func controlDeltagarId()->Bool{
        
        let deltagarid:NSString = deltagaridTextview.text!
        if ( deltagarid.isEqualToString("") ){
            
            let alertControler = UIAlertController(title: "Felaktig inmatning", message: "Du måste skriva in ett deltagarid?", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    
    
    @IBAction func condition1Chosen()
    {
        globalCondition = 1
        startExperiment()
    }
    
    @IBAction func condition2Chosen()
    {
        globalCondition = 2
        startExperiment()
    }

    @IBAction func condition3Chosen()
    {
        globalCondition = 3
        startExperiment()
    }
    
    func startExperiment()
    {
        //Kontrollera att deltagarid har matats in
        if controlDeltagarId(){
            // Kontrollera att deltagarid't inte existerar sedan tidigare
            if deltagaridExists() == 1 {
                if saveDeltagarid(){
                    globalDeltagarid = deltagaridTextview.text!
                    createDeltagaridCoredata()
                    
                    performSegueWithIdentifier("segueStartStartmeasure", sender: nil)
                    
                }
            }
        }
        
    }
    
    @IBAction func saveResults()
    {
        if saveMesurements(){
            
            self.ejSparadeTextview.text = nonSavedMeasures()
            
            let alertControler = UIAlertController(title: "Spara!", message: "Spara lyckades", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
        }
    }
    
    func nonSavedMeasures()->String{
        
        var measurements:[Measurement] = []
        measurements = getMeasurements()
        
        let dateFormatterDT = NSDateFormatter()
        dateFormatterDT.dateFormat = "dd-MMM-yy HH:mm:ss"
        dateFormatterDT.locale = NSLocale(localeIdentifier: "en-US")
        
        var retur:String = ""
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            if (measurements.count == 0 ){
                
                retur = "Inga mätningar att spara"
            }
            
            for measurement in measurements
            {
                retur = retur + measurement.deltagarId + " " + dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.startTime)) + " \r"
            }
            return retur
        }
        return "Funktionen nonSaveMeasures misslyckades"
    }
    
    
    func saveMesurements()->Bool{
        
        var measurements:[Measurement] = []
        measurements = getMeasurements()
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            if (measurements.count == 0 ){
                
                let alertControler = UIAlertController(title: "Spara", message: "Det finns inga poster att skapa", preferredStyle: UIAlertControllerStyle.Alert)
                alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertControler, animated: true, completion: nil)
                return false
            }
            
            for measurement in measurements
            {
                if updateMeasurement(measurement){
                    managedObjectContext.deleteObject(measurement)
                }
                else{
                    return false
                }
            }
        }
        return true
    }
    
    func getMeasurements()->[Measurement]{
        var measurements:[Measurement] = []
        
        var fetchResultController:NSFetchedResultsController
        let fetchRequest = NSFetchRequest(entityName: "Measurement")
        let sortDescriptor = NSSortDescriptor(key: "deltagarId", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            var e: NSError?
            var result: Bool
            do {
                try fetchResultController.performFetch()
                result = true
            } catch let error as NSError {
                e = error
                result = false
            }
            measurements = fetchResultController.fetchedObjects as! [Measurement]
            
            if result != true {
                print(e?.localizedDescription)
            }
        }
        return measurements
    }
    
    func deltagaridExists()->Int{
        //returnerar 1 om deltagarid inte finns, 0 om någonting gått fel och 2 om deltagarid finns.
        let deltagarId:NSString = deltagaridTextview.text!
        
        do {
            let post:NSString = "deltagarid=\(deltagarId)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy3/deltagaridexists.php")!
        
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1) // Deltagarid finns inte
                    {
                        NSLog("Found deltagarid");
                        
                        return 1
                        
                    }
                    else if (success == 2){ //Deltagarid finns
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        let alertControler = UIAlertController(title: "Initiering av undersökningen misslyckades!", message: String(error_msg), preferredStyle: UIAlertControllerStyle.Alert)
                        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertControler, animated: true, completion: nil)
                        
                        return 2
                        
                    }
                    else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        
                        let alertControler = UIAlertController(title: "Initiering av undersökningen misslyckades!", message: String(error_msg), preferredStyle: UIAlertControllerStyle.Alert)
                        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertControler, animated: true, completion: nil)
                        
                        return 0
                        
                    }
                    
                } else {
                    let alertControler = UIAlertController(title: "Initiering av undersökningen misslyckades!", message: "Connection Failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertControler, animated: true, completion: nil)
                    
                    return 0
                }
            } else {
                let alertControler = UIAlertController(title: "Initiering av undersökningen misslyckades!", message: "Connection Failure", preferredStyle: UIAlertControllerStyle.Alert)
                alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertControler, animated: true, completion: nil)
                
                
                return 0
            }
        } catch {
            let alertControler = UIAlertController(title: "Initiering av undersökningen misslyckades!", message: "Server Error", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
            return 0
        }
        
        
    }
    
    func saveDeltagarid()->Bool{
        let deltagarId:NSString = deltagaridTextview.text!
        
        do {
            
            let post:NSString = "deltagarid=\(deltagarId)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy3/insertomgang.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("Spara SUCCESS");
                        
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        let alertControler = UIAlertController(title: "Spara misslyckades!", message: String(error_msg), preferredStyle: UIAlertControllerStyle.Alert)
                        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertControler, animated: true, completion: nil)
                        
                        return false
                        
                    }
                    
                } else {
                    
                    let alertControler = UIAlertController(title: "Spara misslyckades", message: "Connection Failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertControler, animated: true, completion: nil)
                    
                    return false
                }
            }  else {
                let alertControler = UIAlertController(title: "Spara misslyckades!", message: "Connection Failure", preferredStyle: UIAlertControllerStyle.Alert)
                alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertControler, animated: true, completion: nil)
                
                
                return false
            }
        } catch {
            let alertControler = UIAlertController(title: "Spara misslyckades!", message: "Server Error!", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
            
            return false
        }
        return true
    }
    
    func createDeltagaridCoredata(){
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement",inManagedObjectContext: managedObjectContext) as! Measurement
            measurement.deltagarId = globalDeltagarid
        }
    }
    
    
    func updateMeasurement( measurement:Measurement)->Bool{
        
        let dateFormatterDT = NSDateFormatter()
        dateFormatterDT.dateFormat = "dd-MMM-yy HH:mm:ss"
        dateFormatterDT.locale = NSLocale(localeIdentifier: "en-US")
        
        let dateFormatterT = NSDateFormatter()
        dateFormatterT.dateFormat = "HH:mm:ss"
        
        let condition:NSString = String(measurement.condition)
        let deltagarid:NSString = measurement.deltagarId
        //let EndTime:NSString = dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.endTime))
        let StartTime:NSString = dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.startTime))
        let totalAssignments:NSString = String(measurement.totalAssignments)
        //let totalFinished:NSString = String(measurement.totalAssignmentsFinished)
        
        /*
        let assignment1EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment1EndTime))
        let assignment1StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment1StartTime))
        
        let assignment2EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment2EndTime))
        let assignment2StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment2StartTime))
        
        let assignment3EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment3EndTime))
        let assignment3StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment3StartTime))
        
        let assignment4EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment4EndTime))
        let assignment4StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment4StartTime))
        
        let assignment5EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment5EndTime))
        let assignment5StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment5StartTime))
*/
        
        do {
            
            let post:NSString = "deltagarid=\(deltagarid)&starttime=\(StartTime)&totalassignments=\(totalAssignments)&experimentalcondition=\(condition)"
            
            
            /*
            let post:NSString = "deltagarid=\(deltagarid)&EndTime=\(EndTime)&StartTime=\(StartTime)&totalAssignments=\(totalAssignments)&totalFinished=\(totalFinished)&assignment1EndTime=\(assignment1EndTime)&assignment1StartTime=\(assignment1StartTime)&assignment2EndTime=\(assignment2EndTime)&assignment2StartTime=\(assignment2StartTime)&assignment3StartTime=\(assignment3StartTime)&assignment3EndTime=\(assignment3EndTime)&assignment4EndTime=\(assignment4EndTime)&assignment4StartTime=\(assignment4StartTime)&assignment5EndTime=\(assignment5EndTime)&assignment5StartTime=\(assignment5StartTime)&experimentalcondition=\(condition)"
            */
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy3/updateomgang.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            //NSASCIIStringEncoding
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("Update SUCCESS");
                        
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        let alertControler = UIAlertController(title: "Update misslyckades!", message: String(error_msg), preferredStyle: UIAlertControllerStyle.Alert)
                        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertControler, animated: true, completion: nil)
                        
                        return false
                        
                    }
                    
                } else {
                    
                    let alertControler = UIAlertController(title: "Update misslyckades", message: "Connection Failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertControler, animated: true, completion: nil)
                    
                    return false
                }
            }  else {
                let alertControler = UIAlertController(title: "Update misslyckades!", message: "Connection Failure", preferredStyle: UIAlertControllerStyle.Alert)
                alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertControler, animated: true, completion: nil)
                
                
                return false
            }
        } catch {
            let alertControler = UIAlertController(title: "Update misslyckades!", message: "Server Error!", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
            
            return false
        }
        return true
    }
    
    
}
