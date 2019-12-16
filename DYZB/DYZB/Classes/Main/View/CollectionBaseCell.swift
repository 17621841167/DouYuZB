//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/13.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var onLineBtn: UIButton!
    
    //MARK: - 定义模型属性
    var anchor : AnchorModel? {
        didSet{
            //0 校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if  anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onlineStr, for: .normal)
            //2昵称的显示
            nickName.text = anchor.nickname
            
            
            //设置封面图片
            guard let iconUrl = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconUrl)
            
        }
    }
}
