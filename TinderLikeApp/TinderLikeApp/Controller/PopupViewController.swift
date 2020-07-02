//
//  PopupViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/23.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController{
    @IBOutlet weak var modalView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.layer.cornerRadius = 10
    }


    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
