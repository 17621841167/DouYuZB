//
//  RecommemdViewController.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
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

class RecommemdViewController: UIViewController {
    private lazy var recommentViewModel : RecommentViewModel  = RecommentViewModel()
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //        collectionView.backgroundColor = UIColor.red
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionViewNormoalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPerttyCellID)
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        collectionView.backgroundColor = UIColor.white
        return collectionView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        recommentViewModel.requestData {
            self.collectionView.reloadData()
        }
    }
    
    
    
    
}
extension RecommemdViewController {
    private func setupUI(){
        
        //1.添加uicollectionView
        view.addSubview(collectionView)
    }
}

extension RecommemdViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommentViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 8
//        }
//        return 4
        let group = recommentViewModel.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        if indexPath.section == 1 {
            cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath)
        }else{
            cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        
        //        cell.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath)
        headerView.backgroundColor = UIColor.white
        
        
        //取出模型
        let group = recommentViewModel.anchorGroups[indexPath.section]
        return headerView
    }
    
}
extension RecommemdViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPerttyItemH)
        }
         return CGSize(width: kItemW, height: kNormalItemH)
    }
}
