//
//  AssignmentViewController.swift
//  Studie2
//
//  Created by johahogb on 06/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import UIKit

// </Timer>      ------------------------------//
import AudioToolbox
import AVFoundation
// </Timer slut>      ------------------------------//
import CoreData

class AssignmentViewController: UIViewController {
    
    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var alternativ1Button:UIButton!
    @IBOutlet var alternativ2Button:UIButton!
    @IBOutlet var alternativ3Button:UIButton!
    @IBOutlet var alternativ4Button:UIButton!
    @IBOutlet var infotextTextview:UITextView!
    @IBOutlet var femtioFemtioButton:UIButton!
    @IBOutlet var answersFromOthersButton:UIButton!

    @IBOutlet var P1Label:UILabel!
    @IBOutlet var P2Label:UILabel!
    @IBOutlet var P3Label:UILabel!
    @IBOutlet var P4Label:UILabel!
    
    

    // </Timer>      ------------------------------//
    var localStartTime:NSTimeInterval = NSTimeInterval()
    var localTimer:NSTimer = NSTimer()
    // </Timer slut>      ------------------------------//


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.alternativ1Button.setTitle("(A) " + globalAssignments[globalCurrentAssignment].alternative1,forState: UIControlState.Normal)
        self.alternativ2Button.setTitle("(B) " + globalAssignments[globalCurrentAssignment].alternative2,forState: UIControlState.Normal)
        self.alternativ3Button.setTitle("(C) " + globalAssignments[globalCurrentAssignment].alternative3,forState: UIControlState.Normal)
        self.alternativ4Button.setTitle("(D) " + globalAssignments[globalCurrentAssignment].alternative4,forState: UIControlState.Normal)
        
        
        
        self.infotextTextview.text = globalAssignments[globalCurrentAssignment].infoText
        
        self.infotextTextview.selectable = false
        self.infotextTextview.editable = false
        
        //Ska timer användas
        if globalUseTimer{
            startCounter()
        }
        else{
            self.headlineLabel.text = globalAssignments[globalCurrentAssignment].headline
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
 
        // De här verkar behöva anropas i viewDidAppear annars blir det blå färg på fonten.
        if globalFiftyFiftyUsed{
            FiftyFiftyUsed()
        }
        
        if globalanswersFromOthersUsed{
            AnswersFromOthersUsed()
        }
        
    }
    
    func startCounter() {
        let aSelector : Selector = "localTime"
        localTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        localStartTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func localTime(){
        
        if (Alerter.timeLeft(localStartTime) <= 0.0){
            localTimer.invalidate()
    
            globalAssignments[globalCurrentAssignment].userAnswer = constantUserLateAnswer
            goToNextView()
            
        }
        else{

            self.headlineLabel.text = "Tid kvar: " + String(round(Alerter.timeLeft(localStartTime)*100/100).description)

            Alerter.Vibrate(Alerter.timeLeft(localStartTime))
            
            if Alerter.timeLeft(localStartTime) < globalUseAlertcolorTime{
                if Alerter.AlertColor(Alerter.timeLeft(localStartTime)){
                    self.headlineLabel.backgroundColor = UIColor.redColor()
                }
                else{
                    self.headlineLabel.backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func goToNextView(){
    
        if globalCurrentAssignment < globalAssignments.count - 1 {
            performSegueWithIdentifier("segueResultFast", sender: nil)
        }
        else{
            performSegueWithIdentifier("segueFinishFast", sender: nil)
        }
    }
    
    
    func UpdateMeasurement(){
/*
        let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName: "Measurement")
        //let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as? [Measurement]
        
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest)
        
        if let persons = fetchResults{
            let person = persons[0]
            
            person.isMember = true
            
            if managedObjectContext!.save(&error){
                //println("Person is updated")
            }else{
                //println("Could not save \(error), \(error!.userInfo)")
            }
            
        }else{
            //println("Could not fetch \(error), \(error!.userInfo)")
        }

        
        let contents: NSString?
        do {
        contents = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        } catch _ {
        contents = nil
        }
        */
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarid == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    var managedObject = fetchResults[0]
                    managedObject.setValue(globalAssignments[globalCurrentAssignment].headline, forKey: "headline")
                    //managedObject.setValue("param2", forKey: "attribute_two")
                    //managedObject.setValue("param3", forKey: "attribute_three")
                    
                    try context.save()
                }
            }
            
        } catch _ {
            contents = nil
        }
        
    }
    
    
    @IBAction func alternative1Chosen()
    {
        UpdateMeasurement()
        
        localTimer.invalidate()
        globalAssignments[globalCurrentAssignment].userAnswer = 1
        goToNextView()
    }
    
    @IBAction func alternative2Chosen()
    {
        UpdateMeasurement()
        localTimer.invalidate()
        globalAssignments[globalCurrentAssignment].userAnswer = 2
        goToNextView()
    }

    @IBAction func alternative3Chosen()
    {
        UpdateMeasurement()
        localTimer.invalidate()
        globalAssignments[globalCurrentAssignment].userAnswer = 3
        goToNextView()
    }

    @IBAction func alternative4Chosen()
    {
        UpdateMeasurement()
        localTimer.invalidate()
        globalAssignments[globalCurrentAssignment].userAnswer = 4
        goToNextView()
    }

    @IBAction func fiftyFiftyChosen()
    {
        handleFiftyFifty()
    }
    
    @IBAction func answersFromOthersChosen()
    {
        handleAnswersFromOthers()
    }
    
    func handleAnswersFromOthers(){
    
        AnswersFromOthersUsed()
        
        
        self.P1Label.text = String(globalAssignments[globalCurrentAssignment].percentAlternative1) + "%"
        self.P2Label.text = String(globalAssignments[globalCurrentAssignment].percentAlternative2) + "%"
        self.P3Label.text = String(globalAssignments[globalCurrentAssignment].percentAlternative3) + "%"
        self.P4Label.text = String(globalAssignments[globalCurrentAssignment].percentAlternative4) + "%"
 
        self.P1Label.hidden = false
        self.P2Label.hidden = false
        self.P3Label.hidden = false
        self.P4Label.hidden = false
        
        globalanswersFromOthersUsed = true
        
    }
    
    func handleFiftyFifty(){
    
        for remove in globalAssignments[globalCurrentAssignment].fiftyFiftyRemove{
        
            switch remove {
            case 1:
                let attrStringA = NSAttributedString(string: self.alternativ1Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternativ1Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternativ1Button.enabled = false
            case 2:
                let attrStringA = NSAttributedString(string: self.alternativ2Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternativ2Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternativ2Button.enabled = false
            case 3:
                let attrStringA = NSAttributedString(string: self.alternativ3Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternativ3Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternativ3Button.enabled = false
            case 4:
                let attrStringA = NSAttributedString(string: self.alternativ4Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternativ4Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternativ4Button.enabled = false
            default:
                let attrStringA = NSAttributedString(string: "Error", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternativ4Button.setAttributedTitle(attrStringA, forState: .Normal)
            }
        }
        
        globalFiftyFiftyUsed = true
        
        FiftyFiftyUsed()

    }

    func AnswersFromOthersUsed(){
    
        let attrStringF = NSAttributedString(string: self.answersFromOthersButton.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        self.answersFromOthersButton.setAttributedTitle(attrStringF, forState: .Normal)
        
        //self.femtioFemtioButton.setTitleColor(UIColor (red: 222.0/255.0, green: 27.0/255.0, blue: 114.0/255.0, alpha: 1.0), forState: .Normal)
        
        self.answersFromOthersButton.enabled = false
    
    }

    func FiftyFiftyUsed(){
        
        let attrStringF = NSAttributedString(string: self.femtioFemtioButton.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        self.femtioFemtioButton.setAttributedTitle(attrStringF, forState: .Normal)
        
        //self.femtioFemtioButton.setTitleColor(UIColor (red: 222.0/255.0, green: 27.0/255.0, blue: 114.0/255.0, alpha: 1.0), forState: .Normal)
        
        self.femtioFemtioButton.enabled = false
        
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
