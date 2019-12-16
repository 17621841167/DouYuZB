//
//  CollectionReusableView.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/11.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
  
    
    
    var group : AnchorGroup? {
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_head_normal")
        }
    }
}

//MARK: -
extension CollectionReusableView{
    class func collectionReusableView() -> CollectionReusableView{
        return Bundle.main.loadNibNamed("CollectionReusableView", owner: nil, options: nil)?.first as! CollectionReusableView
    }
}
