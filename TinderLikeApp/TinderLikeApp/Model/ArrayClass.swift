//
//  ArrayClass.swift
//  TinderLikeApp
//
//  Created by SASE Koichiro on 2020/06/23.
//  Copyright © 2020 SASE Koichiro. All rights reserved.
//

import Foundation

class ArrayInfo :Codable {
    let name: String
    let age: Int
    let url: String
    let description: String
    init(name: String, age: Int, url: String, description: String){
        self.name = name
        self.age = age
        self.url = url
        self.description = description
    }
}

var maleImageArray:[ArrayInfo] = []
    
var femaleImageArray:[ArrayInfo] = [
    ArrayInfo(name: "荒川未来", age: 30, url: "miki.jpg", description: "外国人介護職員用のEラーニングサービスや、女性ドライバー向けの求人サイトなど、いくつかのサービスを作りたいと思っています。"),
    ArrayInfo(name: "栗本歩実", age: 33, url: "ayumi.jpg", description: "開発の経験をしたくて入学を決めました。アイデアを形にしてみたいです。プログラミングは初心者なのでお手伝いできないことが多いと思いますが、代わりにハイキングならお手伝いできますので運動不足の方はお声掛けください。"),
    ArrayInfo(name: "高橋悠美", age: 33, url: "yumi.jpg", description: "現在のキャリアに不安を感じ、エンジニア転職を希望し入学しました。将来は海外移住を検討しているので、リモートで世界のどこでも働けるようなエンジニアになりたいです!よろしくお願いします!"),
    ArrayInfo(name: "田崎茉莉花", age: 30, url: "marika.jpg", description: "スタートアップ転職前の一通りの基礎的な知識の習得"),
    ArrayInfo(name: "沼田麻希", age: 30, url: "maki.jpg", description: "作るものを明確にし、企画力とそれに伴う技術力を磨く"),
    ArrayInfo(name: "矢田彩乃", age: 39, url: "ayano.jpg", description: "女性の価値観が多様化する場を提供する。自分の人生に誇りを持つ女性を増やす。"),
    ArrayInfo(name: "余田有希子", age: 35, url: "yukiko.jpg", description: "アメリカ赴任時に感じた「プログラミングコンプレックス」を 解消すべく、ジーズアカデミーに入学しました。全くの初心者なのでついていけるか心配ですが、どうぞ、宜しくお願いいたします!")
    ]

