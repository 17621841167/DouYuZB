//
//  RecommentViewModel.swift
//  DYZB
//
//  Created by wenyimeng on 2019/12/12.
//  Copyright © 2019 liuhangjun. All rights reserved.
//  主要处理网络请求

import UIKit

class RecommentViewModel {
    //MARK: - 懒加载所熟悉
     var cycleModels : [CycleModel] = [CycleModel]()
    
     var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()//颜值数组
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    
}
//MARK: - 发送网络请求
extension RecommentViewModel {
    //请求推荐数据
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
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
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
    
    //请求无限轮播数据
    
    // 请求无线轮播的数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
