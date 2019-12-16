//
//  CollectionViewGameCell.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/16.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
//            imageV.image =
            let iconUrl = URL(string: baseGame?.icon_url ?? "")
            imageV.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
