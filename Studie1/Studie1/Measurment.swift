//
//  Measurment.swift
//  Studie1
//
//  Created by johahogb on 05/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation
import CoreData

class Measurement:NSManagedObject {
    
    @NSManaged var headline:String
    @NSManaged var startTime:CFAbsoluteTime
    @NSManaged var endTime:CFAbsoluteTime
    @NSManaged var participantNumber:String
    
    func duration() -> String{
        return String(format:"%f", endTime - startTime)
    }
    
}