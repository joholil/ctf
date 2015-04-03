//
//  assignemntViewController.swift
//  Studie1
//
//  Created by johahogb on 03/04/15.
//  Copyright (c) 2015 Service research center. All rights reserved.
//

import UIKit

class assignmentViewController: UIViewController {

    @IBOutlet var headlineLabel:UILabel!
    
    
    var assignment = Assignment(headline: "Uppgift 1", descriptionText: "Det här är beskrivningen", logo: "loggan", finishedText: "sluttexten", seconds: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.headlineLabel.text = assignment.headline
        self.headlineLabel.text = assignment.headline
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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