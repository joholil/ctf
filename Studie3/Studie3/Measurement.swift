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
    @NSManaged var deltagarId:String
    @NSManaged var startTime:CFAbsoluteTime
    @NSManaged var endTime:CFAbsoluteTime
    @NSManaged var totalAssignments:Int
    @NSManaged var totalAssignmentsFinished:Int
    
    @NSManaged var assignment1activatedtime:CFAbsoluteTime
    @NSManaged var assignment2activatedtime:CFAbsoluteTime
    @NSManaged var assignment3activatedtime:CFAbsoluteTime
    @NSManaged var assignment4activatedtime:CFAbsoluteTime
    @NSManaged var assignment5activatedtime:CFAbsoluteTime
    @NSManaged var assignment6activatedtime:CFAbsoluteTime
    
    @NSManaged var assignment1checked:Bool
    @NSManaged var assignment2checked:Bool
    @NSManaged var assignment3checked:Bool
    @NSManaged var assignment4checked:Bool
    @NSManaged var assignment5checked:Bool
    @NSManaged var assignment6checked:Bool
    
    @NSManaged var timesoffer1clicked:Int
    @NSManaged var timesoffer2clicked:Int
    @NSManaged var timesoffer3clicked:Int
    @NSManaged var timesoffer4clicked:Int
    @NSManaged var timesoffer5clicked:Int
    @NSManaged var timesoffer6clicked:Int
    
    
    @NSManaged var question1correct:Bool
    @NSManaged var question2correct:Bool
    @NSManaged var question3correct:Bool
    @NSManaged var question4correct:Bool
    @NSManaged var question5correct:Bool
    @NSManaged var question6correct:Bool
    
    @NSManaged var buzzerused:Bool
    @NSManaged var visualwarningused:Bool
    
    @NSManaged var timelookingatoffer1:Double
    @NSManaged var timelookingatoffer2:Double
    @NSManaged var timelookingatoffer3:Double
    @NSManaged var timelookingatoffer4:Double
    @NSManaged var timelookingatoffer5:Double
    @NSManaged var timelookingatoffer6:Double
    
    @NSManaged var timelookingatoffer1first:Double
    @NSManaged var timelookingatoffer2first:Double
    @NSManaged var timelookingatoffer3first:Double
    @NSManaged var timelookingatoffer4first:Double
    @NSManaged var timelookingatoffer5first:Double
    @NSManaged var timelookingatoffer6first:Double
    
    
    
    
    
    
}