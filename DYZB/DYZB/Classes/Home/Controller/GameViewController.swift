//
//  GameViewController.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/16.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10                              //左右间距
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3     //cell宽度
private let kitemH = kItemW * 6 / 5
private let kHeadViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kHeadViewID = "kHeadViewID"
//cell高度
private let kGameCellID = "kGameCellID"
class GameViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var gameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kitemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,withReuseIdentifier: kHeadViewID)
        
        return collectionView
        }()
    fileprivate lazy var topHeadView : CollectionReusableView = {
        let headView = CollectionReusableView.collectionReusableView()
        headView.frame = CGRect(x: 0, y: -(kHeadViewH + kGameViewH), width: kScreenW, height: kHeadViewH)
        headView.iconImageView.image = UIImage(named: "Img_orange")
        headView.titleLabel.text = "常用"
        headView.moreBtn.isHidden = true
        return headView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView  = RecommendGameView.RecommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    
    
}
//MARK: - 设置UI
extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeadView)
        collectionView.addSubview(gameView)

        collectionView.contentInset = UIEdgeInsets(top: kHeadViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameViewModel.loadAllGameData {
            //展示全部游戏
            self.collectionView.reloadData()
            //展示常用游戏
//            let groups = self.gameViewModel.games[0..<10]
            
            self.gameView.groups = Array(self.gameViewModel.games[0..<10])
        }
    }
}
//MARK: - 遵守UICollectionViewDataSource协议
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
//        cell.backgroundColor = UIColor.randomColor()
        let gameModel = gameViewModel.games[indexPath.item]
        cell.baseGame = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionReusableView
        
        headView.titleLabel.text = "全部"
        headView.iconImageView.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden  = true
        return headView
    }
    
}
