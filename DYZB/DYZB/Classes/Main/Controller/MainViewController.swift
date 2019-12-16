//
//  MainViewController.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyname: "Home")
        addChildVc(storyname: "Live")
        addChildVc(storyname: "Follow")
        addChildVc(storyname: "Profile")

    }
    

  
    private func addChildVc(storyname : String)
    {
        //1.通过sb获取控制器
        let childVc = UIStoryboard(name: storyname, bundle: nil).instantiateInitialViewController()!
           
          
        //2.将childVc作为自控制器
        
        addChild(childVc)
    }
}
