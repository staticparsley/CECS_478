//
//  LoginVC.swift
//  f-Humanity
//
//  Created by Ahmed Al Sadiq on 5/2/17.
//  Copyright © 2017 Ahmed Al Sadiq. All rights reserved.
//


import UIKit
import FirebaseAuth


class LoginVC: UIViewController  {

    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        welcomeLbl.center = CGPoint(x: theWidth/2 ,y: 130)
        userText.frame = CGRect(x: 16, y: 200, width: theWidth-32, height: 30)
        passwordText.frame = CGRect(x: 16, y: 240, width: theWidth-32, height: 30)
        loginBtn.center = CGPoint(x: theWidth/2, y: 330)
        registerBtn.center = CGPoint(x: theWidth/2, y: theHeight-30)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginBtn_Click(_ sender: Any) {
        //Creating a main storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Instantiate Navigation Controller
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        
        //Get Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Set Navigation Controller
        appDelegate.window?.rootViewController = naviVC
    }
    
    
    
    /*func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
