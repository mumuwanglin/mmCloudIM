//
//  Inputs.swift
//  mumuCloudIM
//
//  Created by 王林 on 16/2/20.
//  Copyright © 2016年 王林. All rights reserved.
//

import Foundation

struct Inputs: OptionSetType {
    let rawValue: Int
    
    static let user = Inputs(rawValue: 1)
    static let pass = Inputs(rawValue: 1 << 1)
    static let email = Inputs(rawValue: 1 << 2)
}
extension Inputs:BooleanType{
    var boolValue: Bool{
        return self.rawValue == 0b111
    }
}
extension Inputs{
    func isAllOK() -> Bool{
//        return self == [.user , .pass , .email]
//        return self.rawValue == 0b111
        
        //选项的数目
        let count = 3
        
        //找到几项
        var found = 0
        
        //在范围内比较查找
        for time in 0..<count{
            if self.contains(Inputs(rawValue: 1 << time)){
                found++
            }
        }
        
        return found == count
    }
}