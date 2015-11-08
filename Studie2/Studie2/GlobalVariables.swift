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
    Assignment(headline: "Fråga 1", targetBeacon: 1,descriptionText: "Gå till fråga 1.", infoText:"Sport och träning är kul på alla nivåer! Viste du att idrottsförbudet Korpen bildades redan 1945", question: "Ungefär hur många medlemmar är med i Korpen?", alternative1: "A: 100000", alternative2: "B: 250000", alternative3: "C: 750000", alternative4: "D: 1000000", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered ),
    Assignment(headline: "Fråga 2", targetBeacon: 4, descriptionText: "Gå till fråga 2.", infoText:"Visste du att alpin skidåkning är ett sammanfattande begrepp för flera olika sporter? I tävlingssammanhang är de 6 stycken.", question: "Vilket av följande alternativ räknas som en del av alpin skidåkning?", alternative1: "A: Halfpipe", alternative2: "B: Super T", alternative3: "C: Nordisk kombination", alternative4: "D: Super G", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered ),
    Assignment(headline: "Fråga 3", targetBeacon: 5, descriptionText: "Gå till fråga 3.", infoText:"Visste du att under 2015 så var Falun värd för VM i längdskidåkning", question: "Under VM i ländskidor 2015 tog en svenska guld på 10 km fristil. Vem??", alternative1: "A: Charlotte Kalla", alternative2: "B: Anna Haag", alternative3: "C: Ida Ingemarsdotter", alternative4: "D: Hanna Falk", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered )]

/////////////////////////// Ibeacon ///////////////////////////////

let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 0.2
let globalmaxDist: Int = 20
let globalParticipantNumber: String = ""
let globalRightAnswersForSuccess:Int = 1

/////////////////////////// Timer ///////////////////////////////

let globalTimerTime:Double = 30 // Här sätts tiden som man har för att svara på frågan
let globalUseTimer:Bool = false
let globalUseAlertcolorTime:Double = 10 // Här sätts när gränssnittet börja blinka
let globalUseVibrationTime: Double = 6 // Här sätts när vibrationer drar igång

/////////////// Globala variabler /////////////////////////
var globalCondition:Int = 0
var globalCurrentAssignment:Int = 0

