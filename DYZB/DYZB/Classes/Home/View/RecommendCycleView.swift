//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/13.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

private let cycleCellID = "cycleCellID"
class RecommendCycleView: UIView {

    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet{
            
            //1.刷新collectView
            collectionVIew.reloadData()
            //2.设置pageControll个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某个位置
            let indexpath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionVIew.scrollToItem(at: indexpath, at: .left, animated: false)
            
            //4.添加定时器
            removeTimer()
            addCycleTimer()
        }
    }
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override   func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = [] //.none
        
        //注册cell
        collectionVIew.register(UINib(nibName: "CollectionCycleViewCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)
        
     
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout  = collectionVIew.collectionViewLayout as! UICollectionViewFlowLayout
             layout.itemSize = collectionVIew.bounds.size
//             layout.minimumLineSpacing = 0
//             layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//             collectionVIew.isPagingEnabled = true
        
    }
    
    
}
extension RecommendCycleView {
    class func recommentCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycle", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellID, for: indexPath) as! CollectionCycleViewCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
    
    
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //计算偏移量
//        let offsetX = scrollView.contentOffset.x

        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width/2
        
        //计算pageControl 的currentPage
        pageControl.currentPage =  Int(offsetX/scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK: - 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToeNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeTimer() {
        cycleTimer?.invalidate()//从运行循环中移除
    }
    @objc private func scrollToeNext(){
         // 1.获取滚动的偏移量
               let currentOffsetX = collectionVIew.contentOffset.x
               let offsetX = currentOffsetX + collectionVIew.bounds.width
               
               // 2.滚动该位置
               collectionVIew.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
