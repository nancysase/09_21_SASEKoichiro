//
//  LoginViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/24.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit
import FirebaseAuth
import LTMorphingLabel

class LoginViewController: UIViewController, LTMorphingLabelDelegate {

    @IBOutlet weak var titleLabel: LTMorphingLabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupB: UIButton!
    
    @IBOutlet weak var loginB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupB.layer.cornerRadius = 10
        loginB.layer.cornerRadius = 10
        titleLabel.morphingEffect = .sparkle
        titleLabel.textColor = .white
        titleLabel.text = "受講生振り分けアプリ"
    }

    @IBAction func signupButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        self.emailSignUp(email: email, password: password)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        self.emailLogin(email: email, password: password)
    }
    
    func emailSignUp (email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password){
            (result, error) in
            if let error = error as NSError? {
                
            } else {
                self.presentViewController()
            }
        }
    }
    
    func emailLogin (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if let error = error as NSError? {
                
            } else {
                self.presentViewController()
            }
        }
    }
    
    func presentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
