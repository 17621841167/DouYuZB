//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import Foundation


extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()//当前时间
        
        //1970 到现在的秒数  时间间隔
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
