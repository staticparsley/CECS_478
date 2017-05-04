//
//  RegisterVC.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/2/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//

import UIKit
import CoreData

//import Stormpath



class RegisterVC: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let theWidth = view.frame.width
        _ = view.frame.height
        
        userText.frame = CGRect(x: 16, y: 230, width: theWidth - 32, height: 30)
        passwordText.frame = CGRect(x: 16, y: 270, width: theWidth - 32, height: 30)
        registerBtn.center = CGPoint(x: theWidth/2, y: 380)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerbtn_Click(_ sender: Any) {
        
        let user: Users = NSEntityDescription.insertNewObject(forEntityName: "User", into: DatabaseController.persistentContainer.viewContext) as! Users
        
        user.userName = userText.text
        user.password = passwordText.text
        
    }
    
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userText.resignFirstResponder()
        passwordText.resignFirstResponder()
        
        return true
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
