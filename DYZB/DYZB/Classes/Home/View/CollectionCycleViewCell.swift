//
//  CollectionCycleViewCell.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/13.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
   @objc var cycleModel : CycleModel? {
        didSet{
            title.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            imageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
