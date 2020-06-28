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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isLogin() == true{
            print("\(String(describing: Auth.auth().currentUser?.uid))")
            print("\(String(describing: Auth.auth().currentUser?.email))")
        } else {
            self.presentLoginController()
        }
        nextButton.titleLabel?.numberOfLines = 2
        nextButton.titleLabel?.textAlignment = .center
        
        setupNavigationBar()
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

    
}

