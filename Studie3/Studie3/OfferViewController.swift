//
//  OfferViewController.swift
//  Studie3
//
//  Created by johahogb on 01/08/16.
//  Copyright © 2016 Service research center. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController {
    
    var assignmentToShow:Int!
    
    @IBOutlet var offerLabel:UILabel!
    @IBOutlet var offerTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        offerLabel.text = globalAssignments[assignmentToShow].product
        offerTextView.text = globalAssignments[assignmentToShow].offer
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
