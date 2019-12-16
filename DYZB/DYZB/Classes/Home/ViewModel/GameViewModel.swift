//
//  GameViewModel.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/16.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [BaseGameModel] = [BaseGameModel]()
    
}
extension GameViewModel {
    //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["ShortName" : "Name"]) { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}

