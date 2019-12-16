//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/16.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}
extension AmuseViewModel {
    func loadAmuseModel(finishCallback : @escaping() -> ()){
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
        }
        finishCallback()
    }
}
