//
//  ResultViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/24.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var femaleLikeArrayInTV: [ArrayInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return femaleLikeArrayInTV.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.imageView!.image = UIImage(named: femaleLikeArrayInTV[indexPath.row].url)
        cell.nameLabel.text = femaleLikeArrayInTV[indexPath.row].name
        cell.ageLabel.text = String(femaleLikeArrayInTV[indexPath.row].age)
        return cell
    }




}
