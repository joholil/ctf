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
        let sortDescriptor = NSSortDescriptor(key: "headline", ascending: true)
        
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
            measurement.headline = globalAssignments[globalCurrentAssignment].headline
            //measurement.endTime = CFAbsoluteTimeGetCurrent()
            //measurement.startTime = measurmentStartTime
            measurement.deltagarid = globalDeltagarid
        }
    }
    
    func updateMeasurement( measurement:Measurement)->Bool{
        let deltagarid:NSString = measurement.deltagarid
        let headline:NSString = measurement.headline
        
        do {
            
            let post:NSString = "deltagarid=\(deltagarid)&headline=\(headline)"
            
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
