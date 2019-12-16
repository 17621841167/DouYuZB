//
//  CollectionViewNormoalCell.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class CollectionViewNormoalCell: CollectionBaseCell {
    
    
    
    
    
    @IBOutlet weak var roomNameLabel: UILabel!
    //MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet{
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
            //
        }
    }
    
    
}
