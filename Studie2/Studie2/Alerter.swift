//
//  Alerter.swift
//  Studie2
//
//  Created by johahogb on 08/11/15.
//  Copyright © 2015 Service research center. All rights reserved.
//

import Foundation
import AudioToolbox

class Alerter {

    static func timeLeft (localStartTime:NSTimeInterval) ->Double{
        var timeLeft:Double = 0.0
        var localRoundedElapsedTime:Double = 0.0
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        let elapsedTime = currentTime - localStartTime
        localRoundedElapsedTime = (round(elapsedTime*100)/100)
        timeLeft = globalTimerTime - localRoundedElapsedTime
        
        return timeLeft
    }
    
    static func Vibrate(timeLeft:Double){
        
        let x:Float = Float(timeLeft)%1
        
        if timeLeft < globalUseVibrationTime {
            if x <= 0.5 {
                
            }
            else{
                globalbuzzerUsed = true
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }

    static func AlertColor(timeLeft:Double) -> Bool{
        var retur:Bool
        
        retur = false
        
        let x:Float = Float(timeLeft)%1
        
        if timeLeft < globalUseAlertcolorTime {
            globalvisualWarningUsed = true
            if x <= 0.5 {
                retur = true
            }
            else{
                retur = false
            }
        }
        
        return retur
    
    }


}