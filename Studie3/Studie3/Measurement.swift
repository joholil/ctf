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
    
    
    
}