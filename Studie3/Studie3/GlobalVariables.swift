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
    Assignment(product: "Avokado", checked: false,assignmentNumber: 1, targetBeacon: 1, offer: "Du kan just nu köpa 2 avocado för halva priset", beacontriggered: false, answered: false, qheadline:"Fråga om avokado", qquestion: "Vilket land i värdled har mest tillvärkning av kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:1, qfiftyFiftyRemove:[2,3], qpercentAlternative1:60, qpercentAlternative2:10,qpercentAlternative3:17,qpercentAlternative4:13),
    Assignment(product: "Bröd", checked: false,assignmentNumber: 2, targetBeacon: 20, offer: "Du kan just nu köpa 2 bröd för halva priset", beacontriggered: false, answered: false, qheadline:"Fråga om avokado", qquestion: "Vilket land i värdled har mest tillvärkning av kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:1, qfiftyFiftyRemove:[2,3], qpercentAlternative1:60, qpercentAlternative2:10,qpercentAlternative3:17,qpercentAlternative4:13),
    Assignment(product: "Citron", checked: false,assignmentNumber: 3, targetBeacon: 30, offer: "Du kan just nu köpa 2 citron för halva priset", beacontriggered: false, answered: false, qheadline:"Fråga om avokado", qquestion: "Vilket land i värdled har mest tillvärkning av kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:1, qfiftyFiftyRemove:[2,3], qpercentAlternative1:60, qpercentAlternative2:10,qpercentAlternative3:17,qpercentAlternative4:13),
    Assignment(product: "Deg", checked: false,assignmentNumber: 5, targetBeacon: 7, offer: "Du kan just nu köpa 2 elkabel för halva priset", beacontriggered: false, answered: false, qheadline:"Fråga om avokado", qquestion: "Vilket land i värdled har mest tillvärkning av kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:1, qfiftyFiftyRemove:[2,3], qpercentAlternative1:60, qpercentAlternative2:10,qpercentAlternative3:17,qpercentAlternative4:13),
    Assignment(product: "Elkabel", checked: false,assignmentNumber: 5, targetBeacon: 50, offer: "Du kan just nu köpa 2 elkabel för halva priset", beacontriggered: false, answered: false, qheadline:"Fråga om avokado", qquestion: "Vilket land i värdled har mest tillvärkning av kravavokado?", qalternative1: "Sverige", qalternative2: "Norge", qalternative3: "Danmark", qalternative4: "Finland", qrightAlternative: 1, quserAnswer:1, qfiftyFiftyRemove:[2,3], qpercentAlternative1:60, qpercentAlternative2:10,qpercentAlternative3:17,qpercentAlternative4:13)]

// Ibeacon //
let globaluuid:String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let globalidentifier:String = "Estimotes"
let globalaccurazyZone: Double = 0.2
let globalmaxDist: Int = 20

// Globala variabler //
var globalCondition:Int = 0
//var globalCurrentAssignment:Int = 0
var globalDeltagarid: String = ""
var globalStartTime: CFAbsoluteTime = CFAbsoluteTime()


