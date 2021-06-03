//
//  Account.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/13.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import Foundation

struct Account : Codable{
    var id: String
    var username: String
    var password: String
    var chinesename: String
    var points: String
    var permission: String
}
