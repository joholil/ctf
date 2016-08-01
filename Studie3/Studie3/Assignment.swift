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
    
    var headline:String
    var targetBeacon:Int
    var descriptionText:String
    var infoText:String
    var question:String
    var alternative1:String
    var alternative2:String
    var alternative3:String
    var alternative4:String
    var rightAlternative:Int
    var userAnswer:Int
    var fiftyFiftyRemove:[Int]
    var percentAlternative1:Int
    var percentAlternative2:Int
    var percentAlternative3:Int
    var percentAlternative4:Int
    
    var rightAnswerText:String {
        get {
            var returnText:String
            
            switch rightAlternative {
            case 1:
                returnText = alternative1
            case 2:
                returnText = alternative2
            case 3:
                returnText = alternative3
            case 4:
                returnText = alternative4
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
            
            switch userAnswer {
            case 1:
                returnText = alternative1
            case 2:
                returnText = alternative2
            case 3:
                returnText = alternative3
            case 4:
                returnText = alternative4
            default:
                returnText = "Kontakta forskaren. Någonting har gått fel"
                break
            }
            
            return returnText
        }
    }
    
    var isAnswered:Bool {
        get {
            if userAnswer != constantAssignmentNotAnswered{
                return true
            }
            else{
                return false
            }
        }
    }
    
    var isRightAnswer:Bool {
        get {
            if rightAlternative == userAnswer{
                return true
            }
            else{
                return false
            }
        }
    }
    
    var isLateAnswer:Bool {
        get {
            if userAnswer == constantUserLateAnswer{
                return true
            }
            else{
                return false
            }
        }
    }
    
    
    static func numberOfRightAnswers( Assignments:[Assignment] ) ->Int
    {
        var rightAnsweres:Int = 0
        
        for assignment in Assignments{
            
            if assignment.isRightAnswer{
                rightAnsweres++
            }
        }
        
        return rightAnsweres
    }
    
    static func numberOfAnswers( Assignments:[Assignment] ) ->Int
    {
        var Answeres:Int = 0
        
        for assignment in Assignments{
            
            if assignment.isAnswered{
                Answeres++
            }
        }
        
        return Answeres
    }
    
    
    
    
    init( headline:String, targetBeacon:Int, descriptionText:String, infoText:String, question:String, alternative1:String, alternative2:String, alternative3:String, alternative4:String, rightAlternative:Int, userAnswer:Int, fiftyFiftyRemove:[Int], percentAlternative1:Int, percentAlternative2:Int, percentAlternative3:Int, percentAlternative4:Int )
    {
        self.headline = headline
        self.descriptionText = descriptionText
        self.targetBeacon = targetBeacon
        self.infoText=infoText
        self.question=question
        self.alternative1=alternative1
        self.alternative2=alternative2
        self.alternative3=alternative3
        self.alternative4=alternative4
        self.rightAlternative=rightAlternative
        self.userAnswer=userAnswer
        self.fiftyFiftyRemove=fiftyFiftyRemove
        self.percentAlternative1=percentAlternative1
        self.percentAlternative2=percentAlternative2
        self.percentAlternative3=percentAlternative3
        self.percentAlternative4=percentAlternative4
        
    }
}