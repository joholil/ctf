//
//  Assignment.swift
//  hicss
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation
import CoreData

class Assignment {
    
    var product:String
    var checked:Bool
    var assignmentNumber:Int
    var targetBeacon:Int
    var offer:String
    var beacontriggered:Bool
    //var answered:Bool
    
    var qheadline:String
    var qquestion:String
    var qalternative1:String
    var qalternative2:String
    var qalternative3:String
    var qalternative4:String
    var qrightAlternative:Int
    var quserAnswer:Int
    var qfiftyFiftyRemove:[Int]
    var qpercentAlternative1:Int
    var qpercentAlternative2:Int
    var qpercentAlternative3:Int
    var qpercentAlternative4:Int

    var qtimelookingatoffer1:Double = 0
    var qtimelookingatoffer2:Double = 0
    var qtimelookingatoffer3:Double = 0
    var qtimelookingatoffer4:Double = 0
    var qtimelookingatoffer5:Double = 0
    
    
    var rightAnswerText:String {
        get {
            var returnText:String
            
            switch qrightAlternative {
            case 1:
                returnText = qalternative1
            case 2:
                returnText = qalternative2
            case 3:
                returnText = qalternative3
            case 4:
                returnText = qalternative4
            default:
                returnText = "Kontakta forskaren. Någonting har gått fel"
                break
            }
            
            return returnText
        }
    }
    
    
    var userAnswerText:String {
        get {
            var returnText:String
            
            switch quserAnswer {
            case 1:
                returnText = qalternative1
            case 2:
                returnText = qalternative2
            case 3:
                returnText = qalternative3
            case 4:
                returnText = qalternative4
            default:
                returnText = "Kontakta forskaren. Någonting har gått fel"
                break
            }
            
            return returnText
        }
    }
    
    /*
    var isAnswered:Bool {
        get {
            if quserAnswer != constantAssignmentNotAnswered{
                return true
            }
            else{
                return false
            }
        }
    }
    */
    var isCorrectAnswer:Bool {
        get {
            if qrightAlternative == quserAnswer{
                return true
            }
            else{
                return false
            }
        }
    }
    
    
    var isLateAnswer:Bool {
        get {
            if quserAnswer == globalConstantUserLateAnswer{
                return true
            }
            else{
                return false
            }
        }
    }
 
    /*
    static func numberOfRightAnswers( Assignments:[Assignment] ) ->Int
    {
        var rightAnsweres:Int = 0
        
        for assignment in Assignments{
            
            if assignment.isCorrectAnswer{
                rightAnsweres += 1
            }
        }
        
        return rightAnsweres
    }
    */
    /*
    static func numberOfAnswers( Assignments:[Assignment] ) ->Int
    {
        var Answeres:Int = 0
        
        for assignment in Assignments{
            
            if assignment.isAnswered{
                Answeres += 1
            }
        }
        
        return Answeres
    }
    */

    func checkedChange() //Håller koll på om användaren checkad av en produkt i listan
    {
        if checked
        {
            checked = false
        }
        else
        {
            checked = true
        }
    }
    
    /*
    init( product:String, checked:Bool, assignmentNumber:Int, targetBeacon:Int, offer:String, beacontriggered:Bool, answered:Bool, qheadline:String, qquestion:String, qalternative1:String, qalternative2:String, qalternative3:String, qalternative4:String, qrightAlternative:Int, quserAnswer:Int, qfiftyFiftyRemove:[Int], qpercentAlternative1:Int, qpercentAlternative2:Int, qpercentAlternative3:Int, qpercentAlternative4:Int)
    */
    init( product:String, checked:Bool, assignmentNumber:Int, targetBeacon:Int, offer:String, beacontriggered:Bool, qheadline:String, qquestion:String, qalternative1:String, qalternative2:String, qalternative3:String, qalternative4:String, qrightAlternative:Int, quserAnswer:Int, qfiftyFiftyRemove:[Int], qpercentAlternative1:Int, qpercentAlternative2:Int, qpercentAlternative3:Int, qpercentAlternative4:Int)
    {
        self.product = product
        self.checked = checked
        self.assignmentNumber = assignmentNumber
        self.targetBeacon = targetBeacon
        self.offer = offer
        self.beacontriggered = beacontriggered
        //self.answered = answered
        self.qheadline = qheadline
        self.qquestion = qquestion
        self.qalternative1 = qalternative1
        self.qalternative2 = qalternative2
        self.qalternative3 = qalternative3
        self.qalternative4 = qalternative4
        self.qrightAlternative = qrightAlternative
        self.quserAnswer = quserAnswer
        self.qfiftyFiftyRemove = qfiftyFiftyRemove
        self.qpercentAlternative1 = qpercentAlternative1
        self.qpercentAlternative2 = qpercentAlternative2
        self.qpercentAlternative3 = qpercentAlternative3
        self.qpercentAlternative4 = qpercentAlternative4
        
    }
    

    
}