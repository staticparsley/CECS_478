//
//  UserVC.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/2/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//

import UIKit

class UserVC: UIViewController {

    @IBOutlet weak var resultsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRect(x: 0,y: 0,width: theHeight,height: theHeight - 64)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
