//
//  AmuseViewController.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/16.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat =  10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3/4
private let kPerttyItemH = kItemW * 4/3
private let kHeadViewH : CGFloat = 50


private let kNormalCellID = "kNormalCellID"
private let kPerttyCellID = "kPerttyCellID"
private let kHeadViewID  = "kHeadViewID"
class AmuseViewController: UIViewController {

    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = kItemMargin
//    layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
    layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
    
    let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    //        collectionView.backgroundColor = UIColor.red
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib.init(nibName: "CollectionViewNormoalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        
//    collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeadViewID)
    collectionView.backgroundColor = UIColor.white
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]

    return collectionView
    }()

    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
            setupUI()
    }
    

}

//MARK: - 设置ui
extension AmuseViewController{
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension AmuseViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormoalCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    
}
