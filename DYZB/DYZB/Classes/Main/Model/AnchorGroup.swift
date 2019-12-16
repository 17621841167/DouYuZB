//
//  AnchorGroup.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/12.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    @objc  var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
        /// 组显示的图标
//   @objc  var tag_name : String = ""
    
    @objc var icon_name : String = "home_header_normal"
//    @objc var icon_url : String = ""
     @objc lazy var anchors : [AnchorModel] = [AnchorModel]()

//    override init() {
//        
//    }
//    init(dict : [String : Any]) {
//        super.init()
//        
//        setValuesForKeys(dict)
//        
//    }
//     override func setValue(_ value: Any?, forUndefinedKey key: String) {}
//    
////    override func setValue(_ value: Any?, forKey key: String) {
////        if key == "room_list" {
////            if let daraArray = value as? [[String : NSObject]] {
////                for dict in daraArray {
////                    anchors.append(AnchorModel(dict: dict))
////                }
////            }
////        }
////    }

}
