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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // görs för att stänga keyboard efter retur
        self.deltagaridTextview.delegate = self
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
        //Kontrollera att deltagarid har matats in
        if controlDeltagarId(){
            // Kontrollera att deltagarid't inte existerar sedan tidigare
            if deltagaridExists() == 1 {
                if saveDeltagarid(){
                    
                    globalCondition = 1
                    globalDeltagarid = deltagaridTextview.text!
                    createDeltagaridCoredata()
                    performSegueWithIdentifier("segueStartStartmeasure", sender: nil)
                }
            }
        }
    }
    
    @IBAction func condition2Chosen()
    {
        //Kontrollera att deltagarid har matats in
        if controlDeltagarId(){
            // Kontrollera att deltagarid't inte existerar sedan tidigare
            if deltagaridExists() == 1 {
                if saveDeltagarid(){
                    //createDeltagaridCoredata()
                    globalCondition = 2
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
        
            let alertControler = UIAlertController(title: "Spara!", message: "Spara lyckades", preferredStyle: UIAlertControllerStyle.Alert)
            alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertControler, animated: true, completion: nil)
            
        }
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
        let sortDescriptor = NSSortDescriptor(key: "deltagarid", ascending: true)
        
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
            
            //var hej = measurements.count
            
            if result != true {
                print(e?.localizedDescription)
            }
        }
        return measurements
    }
    
    func deltagaridExists()->Int{
        //returnerar 1 om deltagarid inte finns, 0 om någonting gått fel och 2 om deltagarid finns.
        let deltagarid:NSString = deltagaridTextview.text!
        
            do {
                let post:NSString = "deltagarid=\(deltagarid)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy2/deltagaridexists.php")!

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
        let deltagarid:NSString = deltagaridTextview.text!
        
        do {
            
            let post:NSString = "deltagarid=\(deltagarid)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy2/insertspelomgang.php")!
            
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
                measurement.deltagarid = globalDeltagarid
        }
    }
    
    
    func updateMeasurement( measurement:Measurement)->Bool{
    
        var dateFormatterDT = NSDateFormatter()
        dateFormatterDT.dateFormat = "yyyy-MM-dd HH:mm:ss"

        var dateFormatterT = NSDateFormatter()
        dateFormatterT.dateFormat = "HH:mm:ss"
        
        //var hej:String = String(measurement.condition)
        let condition:NSString = String(measurement.condition)
        let deltagarid:NSString = measurement.deltagarid
        let buzzerUsed:NSString = String(Int(measurement.buzzerUsed))
        let gameEndTime:NSString = dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.gameEndTime))
        let gameStartTime:NSString = dateFormatterDT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.gameStartTime))
        let numberOfQuestionsAnswered:NSString = String(measurement.numberOfQuestionsAnswered)
        let successfulGame:NSString = String(Int(measurement.successfulGame))
        let totalQuestions:NSString = String(measurement.totalQuestions)
        let totalrightAnswers:NSString = String(measurement.totalrightAnswers)
        let visualWarningUsed:NSString = String(Int(measurement.visualWarningUsed))
        
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
        
        let assignment6EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment6EndTime))
        let assignment6StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment6StartTime))
        
        let assignment7EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment7EndTime))
        let assignment7StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment7StartTime))
        
        let assignment8EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment8EndTime))
        let assignment8StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment8StartTime))
        
        let assignment9EndTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment9EndTime))
        let assignment9StartTime:NSString = dateFormatterT.stringFromDate(NSDate(timeIntervalSinceReferenceDate: measurement.assignment9StartTime))
       
        
        let assignment1PlayTime:NSString
        let assignment1SearchTime:NSString
        
        let assignment2PlayTime:NSString
        let assignment2SearchTime:NSString
        
        let assignment3PlayTime:NSString
        let assignment3SearchTime:NSString
        
        let assignment4PlayTime:NSString
        let assignment4SearchTime:NSString
        
        let assignment5PlayTime:NSString
        let assignment5SearchTime:NSString
        
        let assignment6PlayTime:NSString
        let assignment6SearchTime:NSString
        
        let assignment7PlayTime:NSString
        let assignment7SearchTime:NSString
        
        let assignment8PlayTime:NSString
        let assignment8SearchTime:NSString
        
        let assignment9PlayTime:NSString
        let assignment9SearchTime:NSString
        
        if globalCondition == 1{
            
            assignment1PlayTime = String(measurement.assignment1EndTime - measurement.assignment1StartTime)
            assignment1SearchTime = String(measurement.assignment1StartTime - measurement.gameStartTime)
            
            assignment2PlayTime = String(measurement.assignment2EndTime - measurement.assignment2StartTime)
            assignment2SearchTime = String(measurement.assignment2StartTime - measurement.assignment1EndTime)
            
            assignment3PlayTime = String(measurement.assignment3EndTime - measurement.assignment3StartTime)
             assignment3SearchTime = String(measurement.assignment3StartTime - measurement.assignment2EndTime)
            
             assignment4PlayTime = String(measurement.assignment4EndTime - measurement.assignment4StartTime)
             assignment4SearchTime = String(measurement.assignment4StartTime - measurement.assignment3EndTime)
            
             assignment5PlayTime = String(measurement.assignment5EndTime - measurement.assignment5StartTime)
             assignment5SearchTime = String(measurement.assignment5StartTime - measurement.assignment4EndTime)
            
             assignment6PlayTime = String(measurement.assignment6EndTime - measurement.assignment6StartTime)
             assignment6SearchTime = String(measurement.assignment6StartTime - measurement.assignment5EndTime)
            
             assignment7PlayTime = String(measurement.assignment7EndTime - measurement.assignment7StartTime)
             assignment7SearchTime = String(measurement.assignment7StartTime - measurement.assignment6EndTime)
            
             assignment8PlayTime = String(measurement.assignment8EndTime - measurement.assignment8StartTime)
             assignment8SearchTime = String(measurement.assignment8StartTime - measurement.assignment7EndTime)
            
             assignment9PlayTime = String(measurement.assignment9EndTime - measurement.assignment9StartTime)
             assignment9SearchTime = String(measurement.assignment9StartTime - measurement.assignment8EndTime)
        }
        else{
            
             assignment1PlayTime = String(0)
             assignment1SearchTime = String(measurement.assignment2StartTime - measurement.gameStartTime)
            
             assignment2PlayTime = String(0)
             assignment2SearchTime = String(measurement.assignment2EndTime - measurement.assignment2StartTime)
            
             assignment3PlayTime = String(0)
             assignment3SearchTime = String(measurement.assignment3EndTime - measurement.assignment3StartTime)
            
             assignment4PlayTime = String(0)
             assignment4SearchTime = String(measurement.assignment4EndTime - measurement.assignment4StartTime)
            
             assignment5PlayTime = String(0)
             assignment5SearchTime = String(measurement.assignment5EndTime - measurement.assignment5StartTime)
            
             assignment6PlayTime = String(0)
             assignment6SearchTime = String(measurement.assignment6EndTime - measurement.assignment6StartTime)
            
             assignment7PlayTime = String(0)
             assignment7SearchTime = String(measurement.assignment7EndTime - measurement.assignment7StartTime)
            
             assignment8PlayTime = String(0)
             assignment8SearchTime = String(measurement.assignment8EndTime - measurement.assignment8StartTime)
            
             assignment9PlayTime = String(0)
             assignment9SearchTime = String(measurement.assignment9EndTime - measurement.assignment9StartTime)
            
        }
        
        do {
            //let post:NSString = "deltagarid=\(deltagarid)"
            
            let post:NSString = "deltagarid=\(deltagarid)&buzzerUsed=\(buzzerUsed)&gameEndTime=\(gameEndTime)&gameStartTime=\(gameStartTime)&numberOfQuestionsAnswered=\(numberOfQuestionsAnswered)&successfulGame=\(successfulGame)&totalQuestions=\(totalQuestions)&totalrightAnswers=\(totalrightAnswers)&visualWarningUsed=\(visualWarningUsed)&assignment1EndTime=\(assignment1EndTime)&assignment1StartTime=\(assignment1StartTime)&assignment2EndTime=\(assignment2EndTime)&assignment2StartTime=\(assignment2StartTime)&assignment3StartTime=\(assignment3StartTime)&assignment3EndTime=\(assignment3EndTime)&assignment4EndTime=\(assignment4EndTime)&assignment4StartTime=\(assignment4StartTime)&assignment5EndTime=\(assignment5EndTime)&assignment5StartTime=\(assignment5StartTime)&assignment6EndTime=\(assignment6EndTime)&assignment6StartTime=\(assignment6StartTime)&assignment7EndTime=\(assignment7EndTime)&assignment7StartTime=\(assignment7StartTime)&assignment8EndTime=\(assignment8EndTime)&assignment8StartTime=\(assignment8StartTime)&assignment9EndTime=\(assignment9EndTime)&assignment9StartTime=\(assignment9StartTime)&assignment1PlayTime=\(assignment1PlayTime)&assignment1SearchTime=\(assignment1SearchTime)&assignment2PlayTime=\(assignment2PlayTime)&assignment2SearchTime=\(assignment2SearchTime)&assignment3PlayTime=\(assignment3PlayTime)&assignment3SearchTime=\(assignment3SearchTime)&assignment4PlayTime=\(assignment4PlayTime)&assignment4SearchTime=\(assignment4SearchTime)&assignment5PlayTime=\(assignment5PlayTime)&assignment5SearchTime=\(assignment5SearchTime)&assignment6PlayTime=\(assignment6PlayTime)&assignment6SearchTime=\(assignment6SearchTime)&assignment7PlayTime=\(assignment7PlayTime)&assignment7SearchTime=\(assignment7SearchTime)&assignment8PlayTime=\(assignment8PlayTime)&assignment8SearchTime=\(assignment8SearchTime)&assignment9PlayTime=\(assignment9PlayTime)&assignment9SearchTime=\(assignment9SearchTime)&experimentalcondition=\(condition)"
            
            //let post:NSString = "username=\(username)&password=\(password)"
            
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "http://www.hip.kau.se/hip/GamificationStudy2/updatespelomgang.php")!
            
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
