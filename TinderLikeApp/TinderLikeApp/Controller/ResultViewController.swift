//
//  ResultViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/24.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var femaleLikeArrayInTV: [ArrayInfo] = []
    var femaleDislikeArrayInTV: [ArrayInfo] = []
    var femaleQuitArrayInTV: [ArrayInfo] = []
    var mysections = [String]()
    var twoDimArray = [[ArrayInfo]]()
    //ストーリーボード以外：大元のviewでtopbar設定した後、バーボタンを宣言（xib上に置かない）
    var logoutButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 30
        mysections = ["iOSコース", "WEBコース", "退学"]
        for _ in 0...2 {
            twoDimArray.append([])
        }
        twoDimArray[0] = femaleLikeArrayInTV
        twoDimArray[1] = femaleDislikeArrayInTV
        twoDimArray[2] = femaleQuitArrayInTV
        logoutButtonItem = UIBarButtonItem(title: "ログアウト", style: .done, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem = logoutButtonItem

    }
    
    @objc func logOut(){
        do{
        try Auth.auth().signOut()
            //ログアウトに成功したら、ログイン画面を表示
        self.presentLoginController()
        } catch let signOutError as NSError{
            print("サインアウトエラー:\(signOutError)")
        }
    }
    
    func presentLoginController() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mysections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mysections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.imageLabel.image = UIImage(named: twoDimArray[indexPath.section][indexPath.row].url)
        cell.nameLabel.text = twoDimArray[indexPath.section][indexPath.row].name
        cell.ageLabel.text = String(twoDimArray[indexPath.section][indexPath.row].age)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popUpVC = PopupViewController()
        self.present(popUpVC, animated: true, completion: nil)
        popUpVC.nameLabel.text = twoDimArray[indexPath.section][indexPath.row].name
        popUpVC.ageLabel.text = String(twoDimArray[indexPath.section][indexPath.row].age)
        popUpVC.descriptionLabel.text = twoDimArray[indexPath.section][indexPath.row].description
    }

    //スワイプして削除のコードが動作しない！！！できれば、削除ではなく、iOSとWEBの対象者のみ、スワイプしたら、それぞれwebか退学か、iOSか退学かの選択肢が表示されて、決定すると、その行は消えて選択したセクションに再表示されるようにしたい・・・
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        self.twoDimArray.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }




}
