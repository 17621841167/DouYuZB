//
//  RecommendGameView.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/13.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    //MARK: - 定义数据属性
    var groups : [BaseGameModel]? {
        didSet{
           
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
    }
}

//MARK: - 提供快速创建的类方法
extension RecommendGameView {
    class func RecommendGameView()  -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


//MARK: - UICollectionViewDataSource
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.yellow
        
        let group = groups![indexPath.item]
        cell.baseGame = group
        return cell
    }
    
    
}
