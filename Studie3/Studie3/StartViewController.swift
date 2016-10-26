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
        dateFormatterDT.dateFormat = "dd-MMM-yy"
        dateFormatterDT.locale = NSLocale(localeIdentifier: "en-US")
        
        let dateFormatterT = NSDateFormatter()
        dateFormatterT.dateFormat = "HH:mm:ss"
        
        let condition:NSString = String(measurement.condition)
        let deltagarid:NSString = measurement.deltagarId
        let StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.startTime))
        let StartDate:NSString = dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.startTime))
        
        let totalAssignments:NSString = String(measurement.totalAssignments)
        
        let assignment1activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment1activatedtime))
        let assignment2activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment2activatedtime))
        let assignment3activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment3activatedtime))
        let assignment4activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment4activatedtime))
        let assignment5activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment5activatedtime))
        let assignment6activatedtime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment6activatedtime))
        
        let assignment1checked:NSString = String(Int(measurement.assignment1checked))
        let assignment2checked:NSString = String(Int(measurement.assignment2checked))
        let assignment3checked:NSString = String(Int(measurement.assignment3checked))
        let assignment4checked:NSString = String(Int(measurement.assignment4checked))
        let assignment5checked:NSString = String(Int(measurement.assignment5checked))
        let assignment6checked:NSString = String(Int(measurement.assignment6checked))
    
        let timesoffer1clicked:NSString = String(Int(measurement.timesoffer1clicked))
        let timesoffer2clicked:NSString = String(Int(measurement.timesoffer2clicked))
        let timesoffer3clicked:NSString = String(Int(measurement.timesoffer3clicked))
        let timesoffer4clicked:NSString = String(Int(measurement.timesoffer4clicked))
        let timesoffer5clicked:NSString = String(Int(measurement.timesoffer5clicked))
        let timesoffer6clicked:NSString = String(Int(measurement.timesoffer6clicked))

        let question1correct:NSString = String(Int(measurement.question1correct))
        let question2correct:NSString = String(Int(measurement.question2correct))
        let question3correct:NSString = String(Int(measurement.question3correct))
        let question4correct:NSString = String(Int(measurement.question4correct))
        let question5correct:NSString = String(Int(measurement.question5correct))
        let question6correct:NSString = String(Int(measurement.question6correct))

        let userAnswer1:NSString = String(Int(measurement.userAnswer1))
        let userAnswer2:NSString = String(Int(measurement.userAnswer2))
        let userAnswer3:NSString = String(Int(measurement.userAnswer3))
        let userAnswer4:NSString = String(Int(measurement.userAnswer4))
        let userAnswer5:NSString = String(Int(measurement.userAnswer5))
        let userAnswer6:NSString = String(Int(measurement.userAnswer6))

        
        let buzzerused:NSString = String(Int(measurement.buzzerused))
        let visualwarningused:NSString = String(Int(measurement.visualwarningused))

        let timelookingatoffer1:NSString = String(measurement.timelookingatoffer1)
        let timelookingatoffer2:NSString = String(measurement.timelookingatoffer2)
        let timelookingatoffer3:NSString = String(measurement.timelookingatoffer3)
        let timelookingatoffer4:NSString = String(measurement.timelookingatoffer4)
        let timelookingatoffer5:NSString = String(measurement.timelookingatoffer5)
        let timelookingatoffer6:NSString = String(measurement.timelookingatoffer6)

        let timelookingatoffer1first:NSString = String(measurement.timelookingatoffer1first)
        let timelookingatoffer2first:NSString = String(measurement.timelookingatoffer2first)
        let timelookingatoffer3first:NSString = String(measurement.timelookingatoffer3first)
        let timelookingatoffer4first:NSString = String(measurement.timelookingatoffer4first)
        let timelookingatoffer5first:NSString = String(measurement.timelookingatoffer5first)
        let timelookingatoffer6first:NSString = String(measurement.timelookingatoffer6first)

        
        do {
            
            let post:NSString = "deltagarid=\(deltagarid)&starttime=\(StartTime)&startdate=\(StartDate)&totalassignments=\(totalAssignments)&experimentalcondition=\(condition)&assignment1activatedtime=\(assignment1activatedtime)&assignment2activatedtime=\(assignment2activatedtime)&assignment3activatedtime=\(assignment3activatedtime)&assignment4activatedtime=\(assignment4activatedtime)&assignment5activatedtime=\(assignment5activatedtime)&assignment6activatedtime=\(assignment6activatedtime)&assignment1checked=\(assignment1checked)&assignment2checked=\(assignment2checked)&assignment3checked=\(assignment3checked)&assignment4checked=\(assignment4checked)&assignment5checked=\(assignment5checked)&assignment6checked=\(assignment6checked)&timesoffer1clicked=\(timesoffer1clicked)&timesoffer2clicked=\(timesoffer2clicked)&timesoffer3clicked=\(timesoffer3clicked)&timesoffer4clicked=\(timesoffer4clicked)&timesoffer5clicked=\(timesoffer5clicked)&timesoffer6clicked=\(timesoffer6clicked)&question1correct=\(question1correct)&question2correct=\(question2correct)&question3correct=\(question3correct)&question4correct=\(question4correct)&question5correct=\(question5correct)&question6correct=\(question6correct)&buzzerused=\(buzzerused)&visualwarningused=\(visualwarningused)&timelookingatoffer1=\(timelookingatoffer1)&timelookingatoffer2=\(timelookingatoffer2)&timelookingatoffer3=\(timelookingatoffer3)&timelookingatoffer4=\(timelookingatoffer4)&timelookingatoffer5=\(timelookingatoffer5)&timelookingatoffer6=\(timelookingatoffer6)&timelookingatoffer1first=\(timelookingatoffer1first)&timelookingatoffer2first=\(timelookingatoffer2first)&timelookingatoffer3first=\(timelookingatoffer3first)&timelookingatoffer4first=\(timelookingatoffer4first)&timelookingatoffer5first=\(timelookingatoffer5first)&timelookingatoffer6first=\(timelookingatoffer6first)&userAnswer1=\(userAnswer1)&userAnswer2=\(userAnswer2)&userAnswer3=\(userAnswer3)&userAnswer4=\(userAnswer4)&userAnswer5=\(userAnswer5)&userAnswer6=\(userAnswer6)"
            
            
            
            
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
