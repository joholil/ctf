//
//  GlobalVariables.swift
//  Studie1
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation

/*

self.headline = headline
self.descriptionText = descriptionText
self.targetBeacon = targetBeacon
self.infoText=InfoText
self.question=question
self.alternative1=alternative1
self.alternative2=alternative2
self.alternative3=alternative3
self.alternative4=alternative4
self.rightAlternative=rightAlternative
*/

let globalAssignments:[Assignment] = [
    Assignment(headline: "Fråga 1", targetBeacon: 1,descriptionText: "Gå till fråga 1.", infoText:"Sport och träning är kul på alla nivåer! Viste du att idrottsförbudet Korpen bildades redan 1945", question: "Ungefär hur många medlemmar är med i Korpen?", alternative1: "A: 100000", alternative2: "B: 250000", alternative3: "C: 750000", alternative4: "D: 1000000", rightAlternative: 4 ),
    Assignment(headline: "Fråga 2", targetBeacon: 4, descriptionText: "Gå till fråga 2.", infoText:"Visste du att alpin skidåkning är ett sammanfattande begrepp för flera olika sporter? I tävlingssammanhang är de 6 stycken.", question: "Vilket av följande alternativ räknas som en del av alpin skidåkning?", alternative1: "A: Halfpipe", alternative2: "B: Super T", alternative3: "C: Nordisk kombination", alternative4: "D: Super G", rightAlternative: 4 ),
    Assignment(headline: "Fråga 3", targetBeacon: 5, descriptionText: "Gå till fråga 3.", infoText:"Visste du att under 2015 så var Flun värd för VMi längdskidåkning", question: "Under VM i ländskidor 2015 tog en svenska guld på 10 km fristil. Vem??", alternative1: "A: Charlotte Kalla", alternative2: "B: Anna Haag", alternative3: "C: Ida Ingemarsdotter", alternative4: "D: Hanna Falk", rightAlternative: 1 )]

/*
let globalAssignments:[Assignment] = [Assignment(headline: "Uppgift 1", descriptionText: "Som din första uppgift ska du gå bort till klädavdelningen för vuxna. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din te/Users/johahogb/Documents/ctf/Studie2/Studie2/GlobalVariables.swiftlefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 1, descriptionTextShort: "Gå till grillprodukterna vid marknaden och leta reda på skylten märkt med Karlstads universitets logotyp."), Assignment(headline: "Uppgift 2", descriptionText: "Som din andra uppgift ska du gå bort till mjölkavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 4,  descriptionTextShort: "Gå till området kök och hem och leta reda på skylten märkt med Karlstads universitets logotyp."), Assignment(headline: "Uppgift 3", descriptionText: "Som din tredje uppgift ska du gå bort till mjölavdelning. Där ska du leta redaß på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 5,  descriptionTextShort: "Gå till bokavdelningen och leta reda på skylten märkt med Karlstads universitets logotyp."), Assignment(headline: "Uppgift 4", descriptionText: "Som din fjärde uppgift ska du gå bortß till klädavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 6,  descriptionTextShort: "Gå brödavdelningen och leta reda på skylten märkt med Karlstads universitets logotyp."), Assignment(headline: "Uppgift 5", descriptionText: "Som din femte uppgift ska du gå bort till godisavdelningen. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 8,  descriptionTextShort: "Gå till avdelningen frukt och grönt och leta reda på skylten märkt med Karlstads universitets logotyp.")]
*/

var globalCondition:Int = 0
//
var globalCurrentAssignment:Int = 0

var globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
var globalidentifier:String = "Estimotes"
var globalaccurazyZone: Double = 0.2
var globalmaxDist: Int = 20
var globalParticipantNumber: String = ""
