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
    Assignment(headline: "Station 1", targetBeacon: 8,descriptionText: "Please go to station 1.", infoText:"Tennis is considered to be the third most popular sport in the world.", question: "Hur högt är ett tennisnät?", alternative1: "90 cm", alternative2: "100 cm", alternative3: "110 cm", alternative4: "200 cm", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 4], percentAlternative1: 52, percentAlternative2: 18, percentAlternative3: 5, percentAlternative4: 25 ),
    Assignment(headline: "Station 2", targetBeacon: 2, descriptionText: "Please go to station 2.", infoText: "A good rule of thumb for the length of alpine skis is that they are 10 cm shorter than the body length.", question: "Who won the olympic gold medal in giant slalom both in 1988 and in 1992?", alternative1: "Bode Miller", alternative2: "Markus Näslund", alternative3: "Alberto Tomba", alternative4: "Hermann Maier", rightAlternative: 3, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 52, percentAlternative4: 25  ),
    Assignment(headline: "Station 3", targetBeacon: 30, descriptionText: "Gå till fråga 3.", infoText:"Rätt valla på längdskidor är viktigt. När snön varit tinad och sedan frusit igen (hårda spår) är det klistervalla som gäller.", question: "Under VM i längdskidor 2015 tog en svenska guld på 10 km fristil. Vem?", alternative1: "Ida Ingemarsdotter", alternative2: "Kim Martin", alternative3: "Pia Sundhage", alternative4: "Charlotte Kalla", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 25, percentAlternative2: 18, percentAlternative3: 5, percentAlternative4: 52  ),
    Assignment(headline: "Station 4", targetBeacon: 4, descriptionText: "Gå till fråga 4.", infoText:"Löptävlingen Lidingöloppet som ingår i en svensk klassiker är idag världens största terränglopp.", question: "Hur långt är ett maraton?", alternative1: "42 km", alternative2: "10 km", alternative3: "5 km", alternative4: "400m", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 3], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5  ),
    Assignment(headline: "Station 5", targetBeacon: 5, descriptionText: "Gå till fråga 5.", infoText:"Det svenska U21-landslaget blev under 2015 EM-mästare.", question: "Vilken svensk fotbollsspelare som för närvarande spelar i PSG har vunnit guldbollen 10 gånger?", alternative1: "Zlatan Ibrahimovic", alternative2: "Tomas Brolin", alternative3: "Henrik Larsson", alternative4: "John Guidetti", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5 ),
    Assignment(headline: "Station 6", targetBeacon: 7, descriptionText: "Gå till fråga 6.", infoText:"Simning är en skonsam motionsform som med rätt teknik också fungerar bra för att förbättra konditionen.", question: "Vem blev 2015 första svenska simmare att vinna två VM-guld i samma långbanemästerskap?", alternative1: "Josefin Lillhage", alternative2: "Kajsa Bergkvist", alternative3: "Therese Alshammar", alternative4: "Sarah Sjöström", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 3], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 25, percentAlternative4: 52 )]


/*
 let globalAssignments:[Assignment] = [
 Assignment(headline: "Station 1", targetBeacon: 8,descriptionText: "Gå till fråga 1.", infoText:"Tennis räknas som den tredje mest populära sporten i världen.", question: "Hur högt är ett tennisnät?", alternative1: "90 cm", alternative2: "100 cm", alternative3: "110 cm", alternative4: "200 cm", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 4], percentAlternative1: 52, percentAlternative2: 18, percentAlternative3: 5, percentAlternative4: 25 ),
 Assignment(headline: "Station 2", targetBeacon: 2, descriptionText: "Gå till fråga 2.", infoText: "En bra tumregel för fritidsåkare för längden på alpina skidor är 10 cm kortare än kroppslängden.", question: "Vem vann OS-guld i herrarnas storslalom både 1988 och 1992?", alternative1: "Bode Miller", alternative2: "Markus Näslund", alternative3: "Alberto Tomba", alternative4: "Hermann Maier", rightAlternative: 3, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 52, percentAlternative4: 25  ),
 Assignment(headline: "Station 3", targetBeacon: 3, descriptionText: "Gå till fråga 3.", infoText:"Rätt valla på längdskidor är viktigt. När snön varit tinad och sedan frusit igen (hårda spår) är det klistervalla som gäller.", question: "Under VM i längdskidor 2015 tog en svenska guld på 10 km fristil. Vem?", alternative1: "Ida Ingemarsdotter", alternative2: "Kim Martin", alternative3: "Pia Sundhage", alternative4: "Charlotte Kalla", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 25, percentAlternative2: 18, percentAlternative3: 5, percentAlternative4: 52  ),
 Assignment(headline: "Station 4", targetBeacon: 4, descriptionText: "Gå till fråga 4.", infoText:"Löptävlingen Lidingöloppet som ingår i en svensk klassiker är idag världens största terränglopp.", question: "Hur långt är ett maraton?", alternative1: "42 km", alternative2: "10 km", alternative3: "5 km", alternative4: "400m", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 3], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5  ),
 Assignment(headline: "Station 5", targetBeacon: 5, descriptionText: "Gå till fråga 5.", infoText:"Det svenska U21-landslaget blev under 2015 EM-mästare.", question: "Vilken svensk fotbollsspelare som för närvarande spelar i PSG har vunnit guldbollen 10 gånger?", alternative1: "Zlatan Ibrahimovic", alternative2: "Tomas Brolin", alternative3: "Henrik Larsson", alternative4: "John Guidetti", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5 ),
 Assignment(headline: "Station 6", targetBeacon: 7, descriptionText: "Gå till fråga 6.", infoText:"Simning är en skonsam motionsform som med rätt teknik också fungerar bra för att förbättra konditionen.", question: "Vem blev 2015 första svenska simmare att vinna två VM-guld i samma långbanemästerskap?", alternative1: "Josefin Lillhage", alternative2: "Kajsa Bergkvist", alternative3: "Therese Alshammar", alternative4: "Sarah Sjöström", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 3], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 25, percentAlternative4: 52 )]
 
 */

/*
 
 let globalAssignments:[Assignment] = [
 Assignment(headline: "Station 1", targetBeacon: 1,descriptionText: "Gå till fråga 1.", infoText:"Glöm inte att du bör både slipa och valla dina slalomskidor innan du åker på skidsemester.", question: "Pernilla Wiberg är historiskt sett en av Sveriges mest kända vinteridrottare. I vilken sport tog hon VM-guld 1991?", alternative1: "Bob", alternative2: "Skridskor", alternative3: "Storslalom", alternative4: "Längdskidåkning", rightAlternative: 3, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 4], percentAlternative1: 5, percentAlternative2: 18, percentAlternative3: 52, percentAlternative4: 25 ),
 Assignment(headline: "Station 2", targetBeacon: 2, descriptionText: "Gå till fråga 2.", infoText: "En bra tumregel för fritidsåkare för längden på alpina skidor är 10 cm kortare än kroppslängden.", question: "Vem vann OS-guld i herrarnas storslalom både 1988 och 1992?", alternative1: "Bode Miller", alternative2: "Markus Näslund", alternative3: "Alberto Tomba", alternative4: "Hermann Maier", rightAlternative: 3, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 52, percentAlternative4: 25  ),
 Assignment(headline: "Station 3", targetBeacon: 3, descriptionText: "Gå till fråga 3.", infoText:"Rätt valla på längdskidor är viktigt. När snön varit tinad och sedan frusit igen (hårda spår) är det klistervalla som gäller.", question: "Under VM i längdskidor 2015 tog en svenska guld på 10 km fristil. Vem?", alternative1: "Ida Ingemarsdotter", alternative2: "Kim Martin", alternative3: "Pia Sundhage", alternative4: "Charlotte Kalla", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 2], percentAlternative1: 25, percentAlternative2: 18, percentAlternative3: 5, percentAlternative4: 52  ),
 Assignment(headline: "Station 4", targetBeacon: 4, descriptionText: "Gå till fråga 4.", infoText:"Löptävlingen Lidingöloppet som ingår i en svensk klassiker är idag världens största terränglopp.", question: "Hur långt är ett maraton?", alternative1: "42 km", alternative2: "10 km", alternative3: "5 km", alternative4: "400m", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [2, 3], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5  ),
 Assignment(headline: "Station 5", targetBeacon: 5, descriptionText: "Gå till fråga 5.", infoText:"Det svenska U21-landslaget blev under 2015 EM-mästare.", question: "Vilken svensk fotbollsspelare som för närvarande spelar i PSG har vunnit guldbollen 10 gånger?", alternative1: "Zlatan Ibrahimovic", alternative2: "Tomas Brolin", alternative3: "Henrik Larsson", alternative4: "John Guidetti", rightAlternative: 1, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 52, percentAlternative2: 25, percentAlternative3: 18, percentAlternative4: 5 ),
 Assignment(headline: "Station 6", targetBeacon: 7, descriptionText: "Gå till fråga 6.", infoText:"Simning är en skonsam motionsform som med rätt teknik också fungerar bra för att förbättra konditionen.", question: "Vem blev 2015 första svenska simmare att vinna två VM-guld i samma långbanemästerskap?", alternative1: "Josefin Lillhage", alternative2: "Kajsa Bergkvist", alternative3: "Therese Alshammar", alternative4: "Sarah Sjöström", rightAlternative: 4, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 3], percentAlternative1: 18, percentAlternative2: 5, percentAlternative3: 25, percentAlternative4: 52 )]
 
 */

/*,
 Assignment(headline: "Fraga 7", targetBeacon: 8, descriptionText: "Gå till fråga 7.", infoText:"Visste du att tävlingssim ingick i de första olympiska sommarspelen 1896 i Aten \r \r Hon blev första svenska simmare någonsin att vinna två VM-guld i samma långbanemästerskap?", question: "Använd inte", alternative1: "Therese Alshammar", alternative2: "Sarah Sjöström", alternative3: "Josefin Lillhage", alternative4: "Johanna Sjöberg", rightAlternative: 2, userAnswer: constantAssignmentNotAnswered, fiftyFiftyRemove: [1, 4], percentAlternative1: 17, percentAlternative2: 27, percentAlternative3: 37, percentAlternative4: 47 )]
 
 */

/////////////////////////// Ibeacon ///////////////////////////////

let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 0.2
let globalmaxDist: Int = 20
let globalRightAnswersForSuccess:Int = 4



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
var globalEnglish: Bool = true


