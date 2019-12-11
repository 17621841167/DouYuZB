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
    private var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBar, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()

    //MARK: -系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        //0 不需要调整uuiscorllv的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        
    }
    
}
//MARK: -设置UI界面

extension HomeViewController{
    private func setupUI(){
        view.backgroundColor = UIColor.white
        //1.设置导航栏
        setupNavigationaBar()
//        navigationController?.navigationBar.isTranslucent = false
    }
    private func setupNavigationaBar(){
        
    }
}
