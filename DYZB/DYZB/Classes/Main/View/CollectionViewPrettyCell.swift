//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: CollectionBaseCell {

    //MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    //MARK: - 定义模型属性
    
    
    override var anchor: AnchorModel? {
        didSet {
             // 1.将属性传递给父类
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    
}
