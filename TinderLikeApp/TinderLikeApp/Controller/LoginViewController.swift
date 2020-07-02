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
        if email.isEmpty && password.isEmpty{
            self.showAlert(title: "エラー", message: "メールアドレスとパスワードを入力して下さい")
        } else if email.isEmpty {
            self.showAlert(title: "エラー", message: "メールアドレスを入力して下さい")
        } else if password.isEmpty {
            self.showAlert(title: "エラー", message: "パスワードを入力して下さい")
        } else {
        self.emailSignUp(email: email, password: password)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty && password.isEmpty{
            self.showAlert(title: "エラー", message: "メールアドレスとパスワードを入力して下さい")
        } else if email.isEmpty {
            self.showAlert(title: "エラー", message: "メールアドレスを入力して下さい")
        } else if password.isEmpty {
            self.showAlert(title: "エラー", message: "パスワードを入力して下さい")
        } else {
        self.emailLogin(email: email, password: password)
        }
    }
    
    func emailSignUp (email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password){
            (result, error) in
            if let error = error as NSError? {
                self.signUpError(error)
            } else {
                self.presentViewController()
            }
        }
    }
    
    func emailLogin (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if let error = error as NSError? {
                self.logInError(error)
            } else {
                self.presentViewController()
            }
        }
    }
    
    func presentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func signUpError (_ error: NSError ){
        if let errCode = AuthErrorCode(rawValue: error.code){
            var message = ""
            switch errCode {
            case AuthErrorCode.invalidEmail:
                message = "有効なメールアドレスを入力して下さい"
            case AuthErrorCode.emailAlreadyInUse:
                message = "既に登録されているメールアドレスです"
            case .weakPassword:
                message = "パスワードは６文字以上で入力して下さい"
            default:
                message = "エラー：\(error.localizedDescription)"
            }
            self.showAlert(title: "登録できません", message: message)
        }
    }
    
    func logInError (_ error: NSError){
        if let errCode = AuthErrorCode(rawValue: error.code){
            var message = ""
            switch errCode {
            case .userNotFound:
                message = "アカウントが見つかりませんでした"
            case .wrongPassword:
                message = "パスワードを確認して下さい"
            case .userDisabled:
                message = "アカウントが無効になっています"
            case .invalidEmail:
                message = "E-mailが無効な形式です"
            default:
                message = "エラー：\(error.localizedDescription)"
            }
            self.showAlert(title: "ログインできません", message: message)
        }
    }
    
    func showAlert(title: String, message: String?){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
        

    }
    

}
