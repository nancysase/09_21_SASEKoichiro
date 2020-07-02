//
//  ViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/23.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    

    
    var maleImageList = [String]()
    var imageString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isLogin() == true{
            print("\(String(describing: Auth.auth().currentUser?.uid))")
            print("\(String(describing: Auth.auth().currentUser?.email))")
        } else {
            self.presentLoginController()
        }
        setupNavigationBar()
        nextButton.layer.cornerRadius = 5
        descriptionTextView.layer.cornerRadius = 5
        recordButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameTextField.text = ""
        ageTextField.text = ""
        imageView.image = nil
        descriptionTextView.text = ""
    }
    
    func isLogin() ->Bool{
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    func presentLoginController() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }

    @IBAction func nextButton(_ sender: Any) {
        let nextVC = FemailViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
     // navigation barの設定
    private func setupNavigationBar() {
         //画面上部のナビゲーションバーの左側にログアウトボタンを設置し、押されたらlogOut関数が走るように設定
        let rightButtonItem = UIBarButtonItem(title: "ログアウト", style: .done, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    //ログアウト処理
    @objc func logOut(){
        do{
        try Auth.auth().signOut()
            //ログアウトに成功したら、ログイン画面を表示
        self.presentLoginController()
        } catch let signOutError as NSError{
            print("サインアウトエラー:\(signOutError)")
        }
    }
    
    @IBAction func imageSelectButton(_ sender: Any) {
        let selectVC = ImageSelectViewController()
        selectVC.closure = {(image: UIImage) -> Void in
            self.imageView.image = image
        }
        selectVC.stringClosure = {(imageString: String) -> Void in
            self.imageString = imageString
        }
        self.present(selectVC, animated: true, completion: nil)
    }

    @IBAction func recordTapButton(_ sender: Any) {
        let nextVC = FemailViewController()
        guard let name = nameTextField.text, let age = ageTextField.text, let description = descriptionTextView.text else { return }
        femaleImageArray.append(ArrayInfo(name: name, age: Int(age)!, url: imageString
        , description: description))
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

