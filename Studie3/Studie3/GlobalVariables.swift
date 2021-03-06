//
//  GlobalVariables.swift
//  Studie2
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation

/////////////////////////// Konstanter ///////////////////////////////


let globalAssignments:[Assignment] = [
    Assignment(product: "Bröd i påse", checked: false,assignmentNumber: 1, majorVersion: 1, minorVersion: 0, offer: "", beacontriggered: false, qheadline:"", qquestion: "Från vilket land i världen kommer maträtten Haggis?", qalternative1: "Skottland", qalternative2: "Mexiko", qalternative3: "Tyskland", qalternative4: "Japan", qrightAlternative: 1, quserAnswer:0, qfiftyFiftyRemove:[3,4], qpercentAlternative1:73, qpercentAlternative2:11,qpercentAlternative3:5,qpercentAlternative4:11, picture: "brod.jpg"),
    Assignment(product: "Skivad ost", checked: false,assignmentNumber: 2, majorVersion: 2, minorVersion: 0, offer: "", beacontriggered: false, qheadline:"", qquestion: "Från vilket land kommer korven Bratwurst?", qalternative1: "Sverige", qalternative2: "Brasilien", qalternative3: "Italien", qalternative4: "Tyskland", qrightAlternative: 4, quserAnswer:0, qfiftyFiftyRemove:[1,2], qpercentAlternative1:5, qpercentAlternative2:14,qpercentAlternative3:11,qpercentAlternative4:70, picture: "ost.jpg"),
    Assignment(product: "Tomater i ask", checked: false,assignmentNumber: 3, majorVersion: 3, minorVersion: 0, offer: "Du kan just nu köpa 2 kravodlade citroner för halva priset", beacontriggered: false, qheadline:"Kravodlad citron", qquestion: "Vilket land kommer maträtten Sushi från?", qalternative1: "Japan", qalternative2: "England", qalternative3: "Tyskland", qalternative4: "USA", qrightAlternative: 1, quserAnswer:0, qfiftyFiftyRemove:[2,3], qpercentAlternative1:73, qpercentAlternative2:7,qpercentAlternative3:9,qpercentAlternative4:11, picture: "tomatrom.jpg"),
    Assignment(product: "Smör", checked: false,assignmentNumber: 4, majorVersion: 4, minorVersion: 0, offer: "Du kan just nu köpa 2 miljölampor för halva priset", beacontriggered: false, qheadline:"Miljölampor", qquestion: "Vilket land kommer maträtten fish and ships från?", qalternative1: "USA", qalternative2: "England", qalternative3: "Mocambique", qalternative4: "Angola", qrightAlternative: 2, quserAnswer:0, qfiftyFiftyRemove:[3,4], qpercentAlternative1:7, qpercentAlternative2:73,qpercentAlternative3:9,qpercentAlternative4:11, picture: "smor.jpg"),
    Assignment(product: "Kaffe", checked: false,assignmentNumber: 5, majorVersion: 5, minorVersion: 0, offer: "Du kan just nu köpa 2 kravmärkt mjölkchoklad för halva priset", beacontriggered: false, qheadline:"Mjölkchoklad", qquestion: "Vilket land kommer maträtten Pizza från?", qalternative1: "Iran", qalternative2: "Korea", qalternative3: "Italien", qalternative4: "Indien", qrightAlternative: 3, quserAnswer:0, qfiftyFiftyRemove:[1,4], qpercentAlternative1:7, qpercentAlternative2:9,qpercentAlternative3:70,qpercentAlternative4:14, picture: "kaffe.jpg"),
    Assignment(product: "Mörk chokladkaka", checked: false,assignmentNumber: 6, majorVersion: 6, minorVersion: 0, offer: "Du kan just nu köpa 2 miljölampor för halva priset", beacontriggered: false, qheadline:"Miljölampor", qquestion: "Från vilket land kommer korven Bratwurst?", qalternative1: "Korea", qalternative2: "Sverige", qalternative3: "Norge", qalternative4: "Tyskland", qrightAlternative: 4, quserAnswer:0, qfiftyFiftyRemove:[2,3], qpercentAlternative1:11, qpercentAlternative2:14,qpercentAlternative3:2,qpercentAlternative4:73, picture: "choklad.jpg")]


let globalConstantUserLateAnswer:Int = 99

// Ibeacon //
let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 12
let globalmaxDist: Int = 20

// Globala variabler //
var globalCondition:Int = 0
var globalCurrentAssignment:Int = 0 //Detta är index
var globalFiftyFiftyUsed = false
var globalanswersFromOthersUsed = false
var globalDeltagarid: String = ""
var globalStartTime: CFAbsoluteTime = CFAbsoluteTime()
var globalbuzzerUsed: Bool = false
var globalvisualWarningUsed: Bool = false
var globalEnglish: Bool = false


var globalUseDynamicOfferbuttonsCondition1: Bool = false

// Timer //
let globalTimerTime:Double = 30 // Här sätts tiden som man har för att svara på frågan
let globalUseTimer:Bool = true
let globalUseAlertcolorTime:Double = 10 // Här sätts när gränssnittet börja blinka
let globalUseVibrationTime: Double = 6 // Här sätts när vibrationer drar igång


var globaltimesoffer1clicked:Int = 0
var globaltimesoffer2clicked:Int = 0
var globaltimesoffer3clicked:Int = 0
var globaltimesoffer4clicked:Int = 0
var globaltimesoffer5clicked:Int = 0
var globaltimesoffer6clicked:Int = 0


