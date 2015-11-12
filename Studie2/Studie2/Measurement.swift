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
    
    @NSManaged var deltagarid:String
    @NSManaged var headline:String
    @NSManaged var startTime:CFAbsoluteTime
    @NSManaged var endTime:CFAbsoluteTime
    
    func duration() -> String{
        return String(format:"%f", endTime - startTime)
    }
    
}