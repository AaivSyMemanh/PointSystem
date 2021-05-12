//
//  Account.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/4.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import Foundation

struct Account : Codable{
        var id: Int
        var username: String
        var password: String
        var chinesename: String
        var points: Int
        var permission: Int
}
