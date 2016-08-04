//
//  GlobalVariables.swift
//  Studie2
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation

/////////////////////////// Konstanter ///////////////////////////////
let globalConstantUserLateAnswer:Int = 99

let globalAssignments:[Assignment] = [
    Assignment(product: "Avokado", checked: false,assignmentNumber: 1, targetBeacon: 1, offer: "Du kan just nu köpa 2 avocado för halva priset", beacontriggered: false, qheadline:"Kravodlad avokado", qquestion: "Vilket land i världen odlar mest kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:0, qfiftyFiftyRemove:[2,3], qpercentAlternative1:11, qpercentAlternative2:21,qpercentAlternative3:31,qpercentAlternative4:41),
    Assignment(product: "Bröd", checked: false,assignmentNumber: 2, targetBeacon: 20, offer: "Du kan just nu köpa 2 kravmärkta bröd för halva priset", beacontriggered: false, qheadline:"Kravmärkt bröd", qquestion: "Vilket land i världen har mest tillverkning av kravmärkt bröd?", qalternative1: "USA", qalternative2: "Tyskland", qalternative3: "Kongo", qalternative4: "Serbien", qrightAlternative: 2, quserAnswer:0, qfiftyFiftyRemove:[3,4], qpercentAlternative1:12, qpercentAlternative2:22,qpercentAlternative3:22,qpercentAlternative4:22),
    Assignment(product: "Citron", checked: false,assignmentNumber: 3, targetBeacon: 30, offer: "Du kan just nu köpa 2 kravodlade citroner för halva priset", beacontriggered: false, qheadline:"Kravodlad citron", qquestion: "Vilket land i världen odlar mest krav märkt citron?", qalternative1: "Estland", qalternative2: "Lettland", qalternative3: "Littauen", qalternative4: "Ryssland", qrightAlternative: 3, quserAnswer:0, qfiftyFiftyRemove:[4,1], qpercentAlternative1:13, qpercentAlternative2:23,qpercentAlternative3:33,qpercentAlternative4:43),
    Assignment(product: "Lampor", checked: false,assignmentNumber: 4, targetBeacon: 7, offer: "Du kan just nu köpa 2 miljölampor för halva priset", beacontriggered: false, qheadline:"Miljölampor", qquestion: "Vilket land i världen tillverkar flest miljölampor?", qalternative1: "Brasilien", qalternative2: "Portugal", qalternative3: "Mocambique", qalternative4: "Angola", qrightAlternative: 4, quserAnswer:0, qfiftyFiftyRemove:[1,2], qpercentAlternative1:14, qpercentAlternative2:24,qpercentAlternative3:34,qpercentAlternative4:44),
    Assignment(product: "Choklad", checked: false,assignmentNumber: 5, targetBeacon: 50, offer: "Du kan just nu köpa 2 kravmärkt mjölkchoklad för halva priset", beacontriggered: false, qheadline:"Mjölkchoklad", qquestion: "Vilket land i världen har mest tillverkning av kravmärkt choklad?", qalternative1: "Iran", qalternative2: "Irak", qalternative3: "Israel", qalternative4: "Indien", qrightAlternative: 1, quserAnswer:0, qfiftyFiftyRemove:[2,3], qpercentAlternative1:15, qpercentAlternative2:25,qpercentAlternative3:35,qpercentAlternative4:45)]


// Ibeacon //
let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 0.2
let globalmaxDist: Int = 20

// Globala variabler //
var globalCondition:Int = 0
var globalCurrentAssignment:Int = 0
var globalFiftyFiftyUsed = false
var globalanswersFromOthersUsed = false
var globalDeltagarid: String = ""
var globalStartTime: CFAbsoluteTime = CFAbsoluteTime()
var globalbuzzerUsed: Bool = false
var globalvisualWarningUsed: Bool = false
var globalEnglish: Bool = false


// Timer //
let globalTimerTime:Double = 30 // Här sätts tiden som man har för att svara på frågan
let globalUseTimer:Bool = true
let globalUseAlertcolorTime:Double = 10 // Här sätts när gränssnittet börja blinka
let globalUseVibrationTime: Double = 6 // Här sätts när vibrationer drar igång

