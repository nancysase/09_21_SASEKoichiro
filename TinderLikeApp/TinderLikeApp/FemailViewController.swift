//
//  FemailViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/23.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit
import Koloda
import FirebaseAuth

class FemailViewController: UIViewController,KolodaViewDelegate,KolodaViewDataSource {

    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var iOSLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    //ストーリーボード以外：大元のviewでtopbar設定した後、バーボタンを宣言（xib上に置かない）
    var logoutButtonItem: UIBarButtonItem!
    
    var femaleLikeArray:[ArrayInfo] = []
    var femaleDislikeArray:[ArrayInfo] = []
    var femaleQuitArray:[ArrayInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        logoutButtonItem = UIBarButtonItem(title: "ログアウト", style: .done, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem = logoutButtonItem
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
    
    func presentLoginController() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView(frame: koloda.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: femaleImageArray[index].url)
        koloda.addSubview(imageView)
        return imageView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return femaleImageArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let resultVC = ResultViewController()
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.femaleLikeArrayInTV = femaleLikeArray
        resultVC.femaleDislikeArrayInTV = femaleDislikeArray
        resultVC.femaleQuitArrayInTV = femaleQuitArray
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let popupVC = PopupViewController()
        self.present(popupVC, animated: true, completion: nil)
        popupVC.nameLabel.text = femaleImageArray[index].name
        popupVC.ageLabel.text = String(femaleImageArray[index].age)
        popupVC.descriptionLabel.text = femaleImageArray[index].description
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return[.up, .down, .left]
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        switch direction {
        case .up:
            return femaleLikeArray.append(femaleImageArray[index])
        case .down:
            return femaleDislikeArray.append(femaleImageArray[index])
        case .left:
            return femaleQuitArray.append(femaleImageArray[index])
        default:
            return
        }
    }

}
