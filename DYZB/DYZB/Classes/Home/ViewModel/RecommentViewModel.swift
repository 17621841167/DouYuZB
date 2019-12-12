//
//  RecommentViewModel.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/12.
//  Copyright © 2019 liuhangjun. All rights reserved.
//

import UIKit

class RecommentViewModel {
    //MARK: - 懒加载所熟悉
     lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()

}
//MARK: - 发送网络请求
extension RecommentViewModel {
    func requestData(_ finishCallback : @escaping () -> ()) {
        
        let dGroup = DispatchGroup()

        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //1.请求第一部分推荐数据
        
        dGroup.enter()
               NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
                   
                   // 1.将result转成字典类型
                   guard let resultDict = result as? [String : NSObject] else { return }
                   
                   // 2.根据data该key,获取数组
                   guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
                   
                   // 3.遍历字典,并且转成模型对象
                   // 3.1.设置组的属性
                   self.bigDataGroup.tag_name = "热门"
                   self.bigDataGroup.icon_name = "home_header_hot"
                   
                   // 3.2.获取主播数据
                   for dict in dataArray {
                       let anchor = AnchorModel(dict: dict)
                       self.bigDataGroup.anchors.append(anchor)
                   }
                   
                   // 3.3.离开组
                   dGroup.leave()
               }
        //2.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
                    dGroup.leave()
        }
        //3.后面2-12部分的游戏数据

        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //            print(result)
            //1.将result 转成字典
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            
            guard  let dataArray = resultDic["data"] as? [[String : NSObject]] else {  return }
            
            //便利数组 获取字典 装成模型对象
            for dict in dataArray {
//                let group = AnchorGroup(dict: dict)
                //                for anchor in group.anchors {
                //                    print(anchor.nickname)
                //                }
                //                print(group.tag_name)
            }
            
                 dGroup.leave()
        }
    // 6.所有的数据都请求到,之后进行排序
         
        dGroup.notify(queue: DispatchQueue.main) {
                  
            self.anchorGroups.insert(self.prettyGroup, at: 0)
                   self.anchorGroups.insert(self.bigDataGroup, at: 0)

                   finishCallback()
              
        }
        
    }
    
}
