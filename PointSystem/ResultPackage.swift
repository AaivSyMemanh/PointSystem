//
//  ResultPackage.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/13.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import Foundation

struct pointlogsresult :Codable{
    var status:Int16?
    var info:String?
    var data:Array<pointlog?>
}
