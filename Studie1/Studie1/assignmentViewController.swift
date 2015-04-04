//
//  assignemntViewController.swift
//  Studie1
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit
import CoreFoundation

class assignmentViewController: UIViewController {

    @IBOutlet var headlineLabel:UILabel!
    @IBOutlet var descriptionTestView:UITextView!
    @IBOutlet var logoImageView:UIImageView!
    
    var currentAssignment:Int = 0
    
    
    var assignments:[Assignment] = [Assignment(headline: "Uppgift 1", descriptionText: "Som din första uppgift ska du gå bort till brödavdelningen. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här..."), Assignment(headline: "Uppgift 2", descriptionText: "Som din andra uppgift ska du gå bort till mjölkavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här..."), Assignment(headline: "Uppgift 3", descriptionText: "Som din tredje uppgift ska du gå bort till mjölavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här..."), Assignment(headline: "Uppgift 4", descriptionText: "Som din fjärde uppgift ska du gå bort till klädavdelning. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här..."), Assignment(headline: "Uppgift 5", descriptionText: "Som din femte uppgift ska du gå bort till godisavdelningen. Där ska du leta reda på en gul skyllt märkt med Karlstads Universitet. För din telefon i närheten av skylten tills du får ett meddelande om att du har klarat uppgiften. Märkningen ser ut så här...")]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        initializeAssignment()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeAssignment()
    {
        self.headlineLabel.text = assignments[currentAssignment].headline
        self.descriptionTestView.text = assignments[currentAssignment].descriptionText
        self.logoImageView.image = UIImage(named: "kauLogo")
        assignments[currentAssignment].startTime = CFAbsoluteTimeGetCurrent()
    }
    
    @IBAction func finished()
    {
        if currentAssignment == assignments.count - 1
        {
            if let finishedController = storyboard?.instantiateViewControllerWithIdentifier("finnishedView") as?UIViewController {presentViewController(finishedController, animated: true, completion: nil)
            }
        }
        else
        {
            assignments[currentAssignment].endTime = CFAbsoluteTimeGetCurrent()
            currentAssignment = currentAssignment + 1;
            initializeAssignment()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}