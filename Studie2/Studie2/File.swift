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
    var descriptionText:String
    var descriptionTextShort:String
    var targetBeacon:Int
    //var onRow: Int
    
    
    init( headline:String, descriptionText:String, targetBeacon:Int, descriptionTextShort:String) //, onRow:Int)
    {
        self.headline = headline
        self.descriptionText = descriptionText
        self.targetBeacon = targetBeacon
        self.descriptionTextShort = descriptionTextShort
        //self.onRow = onRow
    }
}