//
//  HomeViewController.swift
//  DYZB
//
//  Created by liuhangjun on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat =  40
class HomeViewController: UIViewController {
    //MARK: -懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()

    
    private lazy var pageContentView : PageContentView = { [weak self] in
        //1,确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBar - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar + kTitleViewH, width: kScreenW, height: contentH)
       //2.确定所有的子控制器
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommemdViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    //MARK: -系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
     
       
    }
    
}
//MARK: -设置UI界面
extension HomeViewController{
    private func setupUI(){
        view.backgroundColor = UIColor.white
        //0 不需要调整uuiscorllv的内边距
        automaticallyAdjustsScrollViewInsets = false

        //1.设置导航栏
        setupNavigationaBar()
        
        //2.添加tiltleView
        view.addSubview(pageTitleView)
        //3添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
             
    }
    private func setupNavigationaBar(){
        
        //        navigationController?.navigationBar.isTranslucent = false
 
        //1.设置左边item
        let btn = UIButton()
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        //2.设置右侧的item
        let size = CGSize(width: 40, height: 40 )
  
//        let historyItem = UIBarButtonItem.createItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
//
//        let searchItem = UIBarButtonItem.createItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
//
//        let qrcpdeItem = UIBarButtonItem.createItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
        let historyItem = UIBarButtonItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
         let searchItem = UIBarButtonItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
         let qrcpdeItem = UIBarButtonItem(imageName: "kw_ic_tab_fenxiang", hightImageName: "kw_ic_tab_fenxiang_seleced", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcpdeItem]
             
        

    }
}

//MARK: - 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//MARK: - 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDeleagte {
    func pageContentView(conetntView: PageContentView, progross: CGFloat, soureIndex: Int, targetIndex: Int) {
             pageTitleView.setTitleWithProgross(progross: progross, sourceIndex: soureIndex, targetIndex: targetIndex)
    }
}
