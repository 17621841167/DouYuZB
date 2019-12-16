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

private let kCycyleView : CGFloat = kScreenW * 3/8
private let kgameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPerttyCellID = "kPerttyCellID"
private let kHeadViewID  = "kHeadViewID"

class RecommemdViewController: UIViewController {
    //    private lazy  var
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
    
    //MARK: - 无限轮播部分
    private lazy var cycleView : RecommendCycleView = {
        let cycyeView = RecommendCycleView.recommentCycleView()
        return cycyeView
    }()
    
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.RecommendGameView()
        
        return gameView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setupUI()
        //
        loadData()
        
    }
    
    
    
    
}
//MARK: - 设置UI
extension RecommemdViewController {
    private func setupUI(){
        
        //1.添加uicollectionView
        view.addSubview(collectionView)
        
        //2.添加无限轮播
        collectionView.addSubview(cycleView)
        cycleView.frame = CGRect(x: 0, y: -(kCycyleView + kgameViewH), width: kScreenW, height: kCycyleView)
        //s设置内边距)
        
        //添加gameView
        collectionView.addSubview(gameView)
        gameView.frame =  CGRect(x: 0, y: -kgameViewH, width: kScreenW, height: kgameViewH)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycyleView + kgameViewH, left: 0, bottom: 0, right: 0)
        
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
        
        //取出模型对象
        let group = recommentViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
        //2.定义cell
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath)
                as! CollectionViewPrettyCell
            
        }else{
            cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormoalCell
            
        }
        cell.anchor = anchor
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionReusableView
        headerView.backgroundColor = UIColor.white
        
        //取出模型
        let group = recommentViewModel.anchorGroups[indexPath.section]
        headerView.group = group
        
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

//MARK: - 请求数据
extension RecommemdViewController {
    private func loadData(){
        //1.请求推荐数据
        recommentViewModel.requestData {
            self.collectionView.reloadData()
            
            //2.将数据传提给gameView
            var groups = self.recommentViewModel.anchorGroups
            //1.移除前;两组数据
            groups.removeFirst()
            groups.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name  = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        
        //2.请求轮播数据
        recommentViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommentViewModel.cycleModels
        }

    }
}
             
