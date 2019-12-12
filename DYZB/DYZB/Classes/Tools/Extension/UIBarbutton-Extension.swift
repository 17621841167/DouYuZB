//
//  UIBarbutton-Extension.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //    class func createItem(imageName : String, hightImageName : String, size : CGSize) -> UIBarButtonItem{
    //
    //        let btn = UIButton()
    //        btn.setImage(UIImage(named: imageName), for: .normal)
    //        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
    //        btn.frame = CGRect(origin: .zero, size: size)
    //        return UIBarButtonItem(customView: btn)
    //
    //    }
    
    
    
    //便利构造函数 1.convenience 开头 2.在构造函数中必须明确调用一个设计构造函数(self)
    convenience init(imageName : String,hightImageName : String, size: CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        self.init(customView : btn)
    }
    
}
