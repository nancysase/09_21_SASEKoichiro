//
//  ImageSelectViewController.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/29.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import UIKit

class ImageSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let maleImageList = ["m_hironori.jpg", "m_keisuke.jpg", "m_syunsuke.jpg", "m_tsuyoshi.jpg", "m_yoshitomo.jpg", "m_yuki.jpg"]
    
    let layout = UICollectionViewFlowLayout() //CollectionViewに含まれているFlowLayoutメソッドを実体化
    
    var closure: ((UIImage) -> Void)? //選択された写真を元の画面に引き継ぐために必要
    var stringClosure:  ((String) -> Void)? //リストにアペンドするために便宜的に必要、urlとして扱えるようになれば不要

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "ImageSelectCell", bundle: nil) //collectionviewの表示
        collectionView.register(nib, forCellWithReuseIdentifier: "ImageSelectCell")
        
        layout.minimumInteritemSpacing = 0 //セル間の隙間
        layout.minimumLineSpacing = 0
        let cellSize = collectionView.frame.width / 2 //セルの幅指定
        layout.itemSize = CGSize(width: cellSize, height: cellSize) //セルの大きさ設定
        collectionView.collectionViewLayout = layout //設定を反映
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maleImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSelectCell", for: indexPath) as! ImageSelectCell
        cell.imageSelect.image = UIImage(named: maleImageList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagePath = UIImage(named: maleImageList[indexPath.item])
        guard let imagePathTo = imagePath else {return}
        closure?(imagePathTo)
        let stringPath = String(maleImageList[indexPath.item])
        stringClosure?(stringPath)
        dismiss(animated: true, completion: nil)
    }
}
