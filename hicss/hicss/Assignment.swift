//
//  Assignment.swift
//  hicss
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation

class Assignment {
    
    var headline:String = ""
    var descriptionText:String = ""
    var logo:String = ""
    var seconds:Int = 0
    var finishedText:String = ""
    
    init( headline:String, descriptionText:String, logo:String, finishedText:String, seconds:Int)
    {
        self.headline = headline
        self.descriptionText = descriptionText
        self.logo = logo
        self.finishedText = finishedText
        self.seconds = seconds
    }
}