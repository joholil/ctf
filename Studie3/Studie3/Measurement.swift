//
//  Measurement.swift
//  Studie2
//
//  Created by johahogb on 12/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//


import Foundation
import CoreData

class Measurement:NSManagedObject {
    
    @NSManaged var condition:Int
    @NSManaged var deltagarid:String
    @NSManaged var questionNumber:Int
    @NSManaged var gameStartTime:CFAbsoluteTime
    @NSManaged var gameEndTime:CFAbsoluteTime
    @NSManaged var buzzerUsed:Bool
    @NSManaged var visualWarningUsed:Bool
    @NSManaged var totalQuestions:Int
    @NSManaged var totalrightAnswers:Int
    @NSManaged var successfulGame:Bool
    @NSManaged var numberOfQuestionsAnswered:Int
    
    @NSManaged var assignment1EndTime:CFAbsoluteTime
    @NSManaged var assignment1StartTime:CFAbsoluteTime
    @NSManaged var assignment2EndTime:CFAbsoluteTime
    @NSManaged var assignment2StartTime:CFAbsoluteTime
    @NSManaged var assignment3EndTime:CFAbsoluteTime
    @NSManaged var assignment3StartTime:CFAbsoluteTime
    @NSManaged var assignment4EndTime:CFAbsoluteTime
    @NSManaged var assignment4StartTime:CFAbsoluteTime
    @NSManaged var assignment5EndTime:CFAbsoluteTime
    @NSManaged var assignment5StartTime:CFAbsoluteTime
    @NSManaged var assignment6EndTime:CFAbsoluteTime
    @NSManaged var assignment6StartTime:CFAbsoluteTime
    @NSManaged var assignment7EndTime:CFAbsoluteTime
    @NSManaged var assignment7StartTime:CFAbsoluteTime
    @NSManaged var assignment8EndTime:CFAbsoluteTime
    @NSManaged var assignment8StartTime:CFAbsoluteTime
    @NSManaged var assignment9EndTime:CFAbsoluteTime
    @NSManaged var assignment9StartTime:CFAbsoluteTime
    
    
    /*
     Möjliga andra variabler
     
     Rätt eller fel per fråga.
     tid mellan frågor
     
     
     */
    
    
    //    func duration() -> String{
    //        return String(format:"%f", endTime - startTime)
    //    }
    
}