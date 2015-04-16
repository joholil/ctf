//
//  GlobalVariables.swift
//  Studie1
//
//  Created by johahogb on 06/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import Foundation

let globalAssignments:[Assignment] = [Assignment(headline: "Uppgift 1", descriptionText: "Som din första uppgift ska du gå bort till brödavdelningen. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 3, descriptionTextShort: "Gå till brödavdelningen och leta reda på skylten märkt med Karlstads universitets logotyp"), Assignment(headline: "Uppgift 2", descriptionText: "Som din andra uppgift ska du gå bort till mjölkavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 8,  descriptionTextShort: "Gå till mjölkavdelning och leta reda på skylten märkt med Karlstads universitets logotyp"), Assignment(headline: "Uppgift 3", descriptionText: "Som din tredje uppgift ska du gå bort till mjölavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 3,  descriptionTextShort: "Gå till mjölavdelning och leta reda på skylten märkt med Karlstads universitets logotyp"), Assignment(headline: "Uppgift 4", descriptionText: "Som din fjärde uppgift ska du gå bort till klädavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 8,  descriptionTextShort: "Gå till klädavdelning och leta reda på skylten märkt med Karlstads universitets logotyp"), Assignment(headline: "Uppgift 5", descriptionText: "Som din femte uppgift ska du gå bort till godisavdelningen. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...", targetBeacon: 3,  descriptionTextShort: "Gå till godisavdelningen och leta reda på skylten märkt med Karlstads universitets logotyp")]


var globalCondition:Int = 0
var globalCurrentAssignment:Int = 0

var globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
var globalidentifier:String = "Estimotes"
var globalaccurazyZone: Double = 0.5
var globalmaxDist: Int = 20
var globalParticipantNumber: String = ""
