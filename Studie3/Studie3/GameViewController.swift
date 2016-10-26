//
//  GameViewController.swift
//  Studie3
//
//  Created by johahogb on 02/08/16.
//  Copyright © 2016 Service research center. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {

    var assignmentToShow:Int!
    
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var alternative1Button:UIButton!
    @IBOutlet var alternative2Button:UIButton!
    @IBOutlet var alternative3Button:UIButton!
    @IBOutlet var alternative4Button:UIButton!
    @IBOutlet var questionTextView:UITextView!
    @IBOutlet var fiftyFiftyButton:UIButton!
    @IBOutlet var answersFromOthersButton:UIButton!
    
    @IBOutlet var P1Label:UILabel!
    @IBOutlet var P2Label:UILabel!
    @IBOutlet var P3Label:UILabel!
    @IBOutlet var P4Label:UILabel!
    //@IBOutlet var headlineLabel:UILabel!
    
    @IBOutlet var visadeltagaridButton:UIButton!
    @IBOutlet var visadeltagaridButtonButton:UIButton!

    
    // </Timer>      ------------------------------//
    var localStartTime:NSTimeInterval = NSTimeInterval()
    var localTimer:NSTimer = NSTimer()
    // </Timer slut>      ------------------------------//
    
    var startTime:CFAbsoluteTime = CFAbsoluteTime()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.alternative1Button.setTitle("(A) " + globalAssignments[assignmentToShow].qalternative1,forState: UIControlState.Normal)
        self.alternative2Button.setTitle("(B) " + globalAssignments[assignmentToShow].qalternative2,forState: UIControlState.Normal)
        self.alternative3Button.setTitle("(C) " + globalAssignments[assignmentToShow].qalternative3,forState: UIControlState.Normal)
        self.alternative4Button.setTitle("(D) " + globalAssignments[assignmentToShow].qalternative4,forState: UIControlState.Normal)
 
        self.questionTextView.text = globalAssignments[assignmentToShow].qquestion
        
        //self.headlineLabel.text = globalAssignments[assignmentToShow].qheadline
        
        self.questionTextView.selectable = false
        self.questionTextView.editable = false
 
        //Ska timer användas
        if globalUseTimer{
            startCounter()
        }
        else{
            self.timeLabel.text = "Time"
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
        startTime = CFAbsoluteTimeGetCurrent()
        
    }
    
    @IBAction func fiftyFiftyChosen()
    {
        handleFiftyFifty()
    }
    
    
    @IBAction func answersFromOthersChosen()
    {
        handleAnswersFromOthers()
    }
  
    @IBAction func alternative1Chosen()
    {
        localTimer.invalidate()
        globalAssignments[assignmentToShow].quserAnswer = 1
        saveResult()
        goToNextView()
    }
    
    
    @IBAction func alternative2Chosen()
    {
        localTimer.invalidate()
        globalAssignments[assignmentToShow].quserAnswer = 2
        saveResult()
        goToNextView()
    }
    
    @IBAction func alternative3Chosen()
    {
        localTimer.invalidate()
        globalAssignments[assignmentToShow].quserAnswer = 3
        saveResult()

        goToNextView()
    }
    
    @IBAction func alternative4Chosen()
    {
        localTimer.invalidate()
        globalAssignments[assignmentToShow].quserAnswer = 4
        saveResult()


        goToNextView()
    }
    
    func goToNextView(){
        
        performSegueWithIdentifier("segueResult", sender: nil)
        
    }
    
    func saveResult(){
        
        let contents: NSString?
        
        do {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "Measurement")
            request.predicate = NSPredicate(format: "deltagarId == %@", globalDeltagarid)
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(request) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    switch assignmentToShow {
                    case 0:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question1correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer1clicked += 1
                            
                            managedObject.setValue(globaltimesoffer1clicked, forKey: "timesoffer1clicked")
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer1")
                    
                    case 1:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question2correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer2clicked += 1
                            managedObject.setValue(globaltimesoffer2clicked, forKey: "timesoffer2clicked")
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer2")
                    
                    case 2:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question3correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer3clicked += 1
                            managedObject.setValue(globaltimesoffer3clicked, forKey: "timesoffer3clicked")
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer3")
                    
                    case 3:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question4correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer4clicked += 1
                            
                            managedObject.setValue(globaltimesoffer4clicked, forKey: "timesoffer4clicked")
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer4")
                    
                    case 4:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question5correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer5clicked += 1
                            
                            managedObject.setValue(globaltimesoffer5clicked, forKey: "timesoffer5clicked")
                            
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer5")
                    
                    case 5:
                        managedObject.setValue(globalAssignments[assignmentToShow].isCorrectAnswer, forKey: "question6correct")
                        if globalAssignments[assignmentToShow].isCorrectAnswer{
                            globaltimesoffer6clicked += 1
                            
                            managedObject.setValue(globaltimesoffer6clicked, forKey: "timesoffer6clicked")
                        }
                        managedObject.setValue(globalAssignments[assignmentToShow].quserAnswer, forKey: "userAnswer6")
                    default:
                        break
                    }
                    
                    managedObject.setValue(globalbuzzerUsed, forKey: "buzzerused")
                    managedObject.setValue(globalvisualWarningUsed, forKey: "visualwarningused")

                    

                    try context.save()
                }
            }
        }
        catch{
            contents = nil
        }
    }
    
    
    func AnswersFromOthersUsed(){
        
        let attrStringF = NSAttributedString(string: self.answersFromOthersButton.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        self.answersFromOthersButton.setAttributedTitle(attrStringF, forState: .Normal)
        
        self.answersFromOthersButton.enabled = false
        
    }
    
    func handleAnswersFromOthers(){
        
        AnswersFromOthersUsed()
        
        
        self.P1Label.text = String(globalAssignments[assignmentToShow].qpercentAlternative1) + "%"
        self.P2Label.text = String(globalAssignments[assignmentToShow].qpercentAlternative2) + "%"
        self.P3Label.text = String(globalAssignments[assignmentToShow].qpercentAlternative3) + "%"
        self.P4Label.text = String(globalAssignments[assignmentToShow].qpercentAlternative4) + "%"
        
        self.P1Label.hidden = false
        self.P2Label.hidden = false
        self.P3Label.hidden = false
        self.P4Label.hidden = false
        
        globalanswersFromOthersUsed = true
        
    }
    
    
    func handleFiftyFifty(){
        
        for remove in globalAssignments[assignmentToShow].qfiftyFiftyRemove{
            
            switch remove {
            case 1:
                let attrStringA = NSAttributedString(string: self.alternative1Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternative1Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternative1Button.enabled = false
            case 2:
                let attrStringA = NSAttributedString(string: self.alternative2Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternative2Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternative2Button.enabled = false
            case 3:
                let attrStringA = NSAttributedString(string: self.alternative3Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternative3Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternative3Button.enabled = false
            case 4:
                let attrStringA = NSAttributedString(string: self.alternative4Button.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
                self.alternative4Button.setAttributedTitle(attrStringA, forState: .Normal)
                self.alternative4Button.enabled = false
            default:
                break
                
            }
        }
        
        globalFiftyFiftyUsed = true
        
        FiftyFiftyUsed()
        
    }
    
    func FiftyFiftyUsed(){
        
        let attrStringF = NSAttributedString(string: self.fiftyFiftyButton.titleForState(.Normal)!, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        self.fiftyFiftyButton.setAttributedTitle(attrStringF, forState: .Normal)
        
        self.fiftyFiftyButton.enabled = false
        
    }
    
    
    func startCounter() {
        let aSelector : Selector = "localTime"
        localTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        localStartTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    
    func localTime(){
        
        if (Alerter.timeLeft(localStartTime) <= 0.0){
            localTimer.invalidate()
            // User was to late
            
            globalAssignments[assignmentToShow].quserAnswer = globalConstantUserLateAnswer
            saveResult()
            
            goToNextView()
            
        }
        else{
            
            if (globalEnglish){
                self.timeLabel.text = "Time left: " + String(round(Alerter.timeLeft(localStartTime)*100/100).description)
                
            }
            else
            {
                self.timeLabel.text = "Tid kvar: " + String(round(Alerter.timeLeft(localStartTime)*100/100).description)
            }
            
            Alerter.Vibrate(Alerter.timeLeft(localStartTime))
            
            if Alerter.timeLeft(localStartTime) < globalUseAlertcolorTime{
                if Alerter.AlertColor(Alerter.timeLeft(localStartTime)){
                    self.timeLabel.backgroundColor = UIColor.redColor()
                }
                else{
                    self.timeLabel.backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueResult") {
            
            //Här sätts variabel i nästa visade dialog
            let NextViewController = (segue.destinationViewController as! ResultViewController)
            NextViewController.assignmentToShow = assignmentToShow
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func showparticipantIdButton()
    {
        
        self.visadeltagaridButton.hidden = false
    }
    
    
    @IBAction func showparticipantId()
    {
        
        self.visadeltagaridButton.hidden = true
        
        let alertControler = UIAlertController(title: "DeltagarId", message: globalDeltagarid, preferredStyle: UIAlertControllerStyle.Alert)
        alertControler.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertControler, animated: true, completion: nil)
        
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
