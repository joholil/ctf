//
//  GlobalVariables.swift
//  Studie2
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation


/////////////////////////// Konstanter ///////////////////////////////
let constantUserLateAnswer:Int = 99
let constantAssignmentNotAnswered = 88

let globalAssignments:[Assignment] = [
    Assignment(headline: "Station 1", targetBeacon: 1,descriptionText: "Gå till fråga 1.", infoText:"Sport och träning är kul på alla nivåer! Viste du att idrottsförbudet Korpen bildades redan 1945.", question: "Ungefär hur många medlemmar är med i Korpen?", alternative1: "100000", alternative2: "250000", alternative3: "750000", alternative4: "1000000", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 11, percentAlternative2: 21, percentAlternative3: 31, percentAlternative4: 41 ),
    Assignment(headline: "Station 2", targetBeacon: 2, descriptionText: "Gå till fråga 2.", infoText:"Visste du att alpin skidåkning är ett sammanfattande begrepp för flera olika sporter? I tävlingssammanhang är de 6 stycken.", question: "Vilket av följande alternativ räknas som en del av alpin skidåkning?", alternative1: "Halfpipe", alternative2: "Super T", alternative3: "Nordisk kombination", alternative4: "Super G", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 12, percentAlternative2: 22, percentAlternative3: 32, percentAlternative4: 42  ),
    Assignment(headline: "Station 3", targetBeacon: 3, descriptionText: "Gå till fråga 3.", infoText:"Visste du att under 2015 så var Falun värd för VM i längdskidåkning.", question: "Under VM i ländskidor 2015 tog en svenska guld på 10 km fristil. Vem?", alternative1: "Charlotte Kalla", alternative2: "Anna Haag", alternative3: "Ida Ingemarsdotter", alternative4: "Hanna Falk", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 13, percentAlternative2: 23, percentAlternative3: 33, percentAlternative4: 43  )]
    
    /*,
    Assignment(headline: "Station 4", targetBeacon: 4, descriptionText: "Gå till fråga 4.", infoText:"Visste du att det svenska mästerskapet i ishockey spelades för först gången 1992.", question: "Hur många SM-titlar i ishockey har Färjestad tagit sedan starten 1992?", alternative1: "Fyra", alternative2: "Sex", alternative3: "Nio", alternative4: "Tolv", rightAlternative: 3, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 14, percentAlternative2: 24, percentAlternative3: 34, percentAlternative4: 44  ),
    Assignment(headline: "Station 5", targetBeacon: 5, descriptionText: "Gå till fråga 5.", infoText:"Visste du att Zlatan har rekordet i flest gjorda mål för det svenska herrlandslaget i fotboll.", question: "Vilken spelare är den näste bäste målgöraren för svenska herrlandslaget?", alternative1: "Henrik Larsson", alternative2: "Gunnar Nordahl", alternative3: "Tomas Brolin", alternative4: "Sven Rydell", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 15, percentAlternative2: 25, percentAlternative3: 35, percentAlternative4: 45 ),
    Assignment(headline: "Station 6", targetBeacon: 7, descriptionText: "Gå till fråga 6.", infoText:"Visste du att träningsredskapet kettlebell från början var ett redskap som användes av bjder för att väga grödor.", question: "Vilket land kommer kettlebells ursprungligen från?", alternative1: "Danmark", alternative2: "Ungern", alternative3: "USA", alternative4: "Ryssland", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 16, percentAlternative2: 26, percentAlternative3: 36, percentAlternative4: 46 )]

*/

/*,
    Assignment(headline: "Fraga 7", targetBeacon: 8, descriptionText: "Gå till fråga 7.", infoText:"Visste du att tävlingssim ingick i de första olympiska sommarspelen 1896 i Aten \r \r Hon blev första svenska simmare någonsin att vinna två VM-guld i samma långbanemästerskap?", question: "Använd inte", alternative1: "Therese Alshammar", alternative2: "Sarah Sjöström", alternative3: "Josefin Lillhage", alternative4: "Johanna Sjöberg", rightAlternative: 2, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 17, percentAlternative2: 27, percentAlternative3: 37, percentAlternative4: 47 )]

*/

/////////////////////////// Ibeacon ///////////////////////////////

let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 0.2
let globalmaxDist: Int = 20
let globalRightAnswersForSuccess:Int = 1

/////////////////////////// Timer ///////////////////////////////

let globalTimerTime:Double = 30 // Här sätts tiden som man har för att svara på frågan
let globalUseTimer:Bool = true
let globalUseAlertcolorTime:Double = 10 // Här sätts när gränssnittet börja blinka
let globalUseVibrationTime: Double = 6 // Här sätts när vibrationer drar igång

/////////////// Globala variabler /////////////////////////
var globalCondition:Int = 0
var globalCurrentAssignment:Int = 0
var globalFiftyFiftyUsed = false
var globalanswersFromOthersUsed = false
var globalDeltagarid: String = ""
var globalGameStartTime: CFAbsoluteTime = CFAbsoluteTime()
var globalbuzzerUsed: Bool = false
var globalvisualWarningUsed: Bool = false


